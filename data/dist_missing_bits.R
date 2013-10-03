#Set working directory
setwd('~/Desktop/paper-1/data')

#Read in the data
missing_pos = read.table('MISSED.txt', header=T)

attach(missing_pos)
hist(missing_pos$positions, breaks = 100, freq = FALSE, right = TRUE, density = 10, angle = 45, col = 'BLUE', border = NULL, main = paste("Histogram of Positions of missing bits"), xlab = "Positions of missing bits")
