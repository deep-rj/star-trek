employment_data <- read.csv('Employment.csv', header = TRUE)

unemployment_data <- read.csv('Unemployment.csv', header = TRUE)

udata <- data.frame(year = character(0), month = character(0), unemployment = numeric(0), 
                    employment = numeric(0), ratio = numeric(0))

for (i in 1:65) {
  for (j in 1:12) {
    udata <- rbind(udata, c(unemployment_data[i,1], j,
                            unemployment_data[i, paste0('X',j)], employment_data[i, paste0('X',j)],
                            unemployment_data[i, paste0('X',j)] / employment_data[i, paste0('X',j)]))
  }
}
colnames(udata) <- c('Year', 'Month', 'Unemployment', 'Employment', 'U/E Ratio')

udata$UE_Delta <- c(NA, diff(udata$`U/E Ratio`))
udata$UE_DeltaPer <- udata$UE_Delta * 100
udata$P_Year <- udata$Year %% 4
udata$P_Flag <- ifelse(udata$Year %% 4 == 2, TRUE, FALSE)
udata$SH_Flag <- ifelse(udata$Year %% 2 == 0, TRUE, FALSE)

udata

write.csv(udata, 'Unemployment_ts.csv', row.names = TRUE)
  


