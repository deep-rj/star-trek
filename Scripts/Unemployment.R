employment_data <- read.csv('Employment.csv', header = TRUE)
View(employment_data)

unemployment_data <- read.csv('Unemployment.csv', header = TRUE)
View(unemployment_data)

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

udata$P_Year <- ifelse(udata$Year %% 4 == 2, TRUE, FALSE)
udata$SH_Year <- ifelse(udata$Year %% 2 == 0, TRUE, FALSE)

udata

write.csv(udata, 'Unemployment_ts.csv', row.names = FALSE)



