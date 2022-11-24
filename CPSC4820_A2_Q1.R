#---------Your Questions start from here---------------

# Coal Consumption analysis and visualization.
# The dataset coal.csv can be downloaded from the D2L.
# This contains coal consumption dataset
# from different regions and countries.
# The data is raw (uncleaned).


# Q1 Load the tidyverse and ggplot library. [2 Marks]
library(tidyverse)
library(ggplot2)

# Q2 Read and view the coal dataset properly. [2 Marks]
filepath <- "~/Library/Mobile Documents/com~apple~CloudDocs/Data Analytics/Semister 4/CPSC4820/Assignments/2/R_viz"
filename <- "coal.csv"

coal <- read.csv(paste(filepath,"/",filename,sep=""),header = TRUE, skip = 2, check.names=FALSE, na.strings="--")

# Q3 Rename the first column as region.
# (The first column has a garbage name) [2 Marks]
colnames(coal)[1]<-"region"

# Q4 Take a close look at the Dataset.
# Most of the columns are redundant
# and mostly represent similar things.
# Convert from a wide dataset to a long dataset.
# After conversion it should only have
# "Region", "year" and "coal_consumption" as its columns. [4 Marks]
coal_long <-
  coal %>%
  pivot_longer(cols=!region,
               names_to = "year",
               values_to = "coal_consumption")


# Q5 Convert years to integers and coal_consumption to numeric. [3 Marks]
library(dplyr)

coal_long <-
  coal_long %>%
  mutate(year=as.integer(year)) %>%
  mutate(coal_consumption=as.numeric(coal_consumption))

str(coal_long)

# Q6 Look at region values - they contain both continents and countries.
# So i have created a vector of "noncountry" values
# that appear in the region variable
noncountries <- c("North America", "Central & South America", "Antarctica", "Europe", "Eurasia",
                  "Middle East", "Africa", "Asia & Oceania", "World")

# Use match and which function,
# to separate the data into 2 dataset tibbles
# based on contries and noncountries. [7 Marks]

coal_noncontries<-tibble(coal_long[which(!is.na(match(coal_long$region, noncountries))),])
coal_contries<-tibble(coal_long[which(is.na(match(coal_long$region, noncountries))),])


# Q7 Find and plot the total coal_consumption by noncountries.
# Use a column graph with x-axis as total coal_consumption
# and y-axis as the noncountries. Use dark blue color for the bars.
# axes labels must be accurate. [5 Marks]

coal_noncontries_total<-
  aggregate(data=coal_noncontries, coal_consumption~region, sum)

colnames(coal_noncontries_total)<-c("non_countries","total_coal_consumption")

ggplot(data=coal_noncontries_total,
       aes(y=non_countries, x=total_coal_consumption)
       ) +
  geom_bar(stat="identity", fill="darkblue")+
  ggtitle("Total Coal Consumption by Noncountries")+
  ylab('Non-countries')+
  xlab('Total Coal Consumption')


# Q8 The dataset of the noncountries coal_consumption
# contains one for the world and rest for other noncountry regions.
# Check with code that the total coal_consumption of the "world" is
# equal or not to the sum of coal consumption from the countries dataset.
# [5 Marks]

world_total<-sum(coal_noncontries_total[coal_noncontries_total$non_countries!="World",'total_coal_consumption'])
countries_total<-sum(coal_contries[,'coal_consumption'],na.rm=TRUE)

if (world_total==countries_total) {
  print("world_total equal to countries_total")
} else {
  print("world_total not equal to countries_total")
}
