# Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for', destfile = 'wksst8110.for', method = 'curl')
res <- read.fwf('wksst8110.for', skip = 4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(res[, 4])
