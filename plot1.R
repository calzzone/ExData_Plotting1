#setwd("/home/calzzone/Desktop/coursera/EDA/A1")
unzip("exdata_data_household_power_consumption.zip")

library(readr)
library(dplyr)
library(lubridate)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

DB <- read_delim(file = "household_power_consumption.txt", delim = ";", na = "?", 
                 col_types = cols(Date = col_character(), Time = col_character()))
#str(DB)
#DB2 <- DB[1:10000, ] # smaller datast used for testing

# make the final dataset
DB3 <- DB %>% 
  mutate(dt = paste(`Date`, `Time`) %>% dmy_hms() ) %>% 
  filter(dt %>% between(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 23:59:59"))) 


# plot 1
png(filename = "plot1.png", 
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "transparent")
hist(DB3$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)") 

dev.off()