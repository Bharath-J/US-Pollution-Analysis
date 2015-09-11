#In this code I will be comparing the ozone levels in the 
#counties of Eastern United States with that of Western United States

#I have downloaded hourly ozone measurements from EPA's Air Quality System webpage
#http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/download_files.html
#and stored in a folder called "data"

#Installing a package called "readr" to read CSV files very fast
install.packages("readr")
library(readr)

ozone <- read_csv("C:/data/hourly_44201_2015.csv", col_types = "ccccinnccccccncnnccccccc")

#Rewriting names of columns to remove any spaces
names(ozone) <- make.names(names(ozone))

#Making a box plot of ozone data, a box for each state
par(las = 2, mar = c(10, 4, 2, 2), cex.axis = 0.8)
boxplot(Sample.Measurement ~ State.Name, ozone, range = 0, ylab = "Ozone Level (ppm)")
x11()

#Dividing the US into East and West based on longitudinal value
#If longitude is less than -100, it is West else East
install.packages("maps")
library(maps)
map("state")
abline(v = -100, lwd = 3)
text(-120, 30, "West")
text(-75, 30, "East")

#Creating a new variable to indicate whether the ozone measurement was recorded 
#in the East or the West
ozone$region <- factor(ifelse(ozone$Longitude < -100, "West","East"))

#Calculating mean and median of ozone levels in Eastern and Western United States.
East_ozone <- subset(ozone, region=="East", select=Sample.Measurement)
East_ozone_mean <- mean(East_ozone$Sample.Measurement)
East_ozone_median <- median(East_ozone$Sample.Measurement)

West_ozone <- subset(ozone, region=="West", select=Sample.Measurement)
West_ozone_mean <- mean(West_ozone$Sample.Measurement)
West_ozone_median <- median(West_ozone$Sample.Measurement)

table(East_ozone_mean, West_ozone_mean, East_ozone_median, West_ozone_median)

