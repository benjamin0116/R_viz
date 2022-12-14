#

#---------Your Questions start from here---------------

# Social Security disability dataset visualization.
# Download the ssadisability.csv dataset from D2L.
# US federal government collects data for Social Security Disability Program.
# As you may know, the Social Security Disability Program
# provides insurance benefits to eligible individuals,
# in the United States, who are unable to work
# because of physical or mental limitations.
# We also have a similar program in Canada Here.


# Q1 Load the tidyverse, lubridate, stringr and ggplot library. [3 Marks]
library(tidyverse)
library(lubridate)
library(stringr)
library(ggplot2)

# Q2 Read and view the ssadisability dataset properly. [2 Marks]

filepath <- "~/Library/Mobile Documents/com~apple~CloudDocs/Data Analytics/Semister 4/CPSC4820/Assignments/2/R_viz"
filename <- "ssadisability.csv"

ssadisability <- read.csv(paste(filepath,"/",filename,sep=""),
                 header = TRUE,
                 check.names=FALSE
                 )

for (cols in colnames(ssadisability)[-1]) {
  ssadisability[cols]<-as.numeric(gsub(",","",ssadisability[[cols]]))
}


# Q3 As you might see most of the data is redundant and tells similar info.
# For each month the dataset has one Total and one Internet coloumn.
# Total for that month represents the total applications received for disability benefits.
# Internet represents applications received for disability benefits online.
# So now convert this wide data into a long data having only
# "Fiscal_Year", "month" and "Applications" column. [5 Marks]


ssadisability_long <-
  ssadisability %>%
  pivot_longer(cols=!Fiscal_Year,
               names_to = "month",
               values_to = "Applications")



# Q4 Now Split the month and application type.
# That means now there will be 4 columns.
# The type column will show either total or internet. [3 Marks]

#one go for Q3 & Q4
#ssadisability_long <-
#  ssadisability %>%
#  pivot_longer(cols=!Fiscal_Year,
#               names_to = c("month","application_type"),
#               names_sep = "_",
#               values_to = "Applications")


ssadisability_long <- separate(data=ssadisability_long,
                              col=month,
                              into=c('month','application_type'),
                              sep='_')



# Q5 If you now look at the months column,
# there are some months which have 3 char representation like "Oct".
# Whereas some have more than 3 characters in them.
# Now trim all the months to have 3 characters. Do not hard code.
# Use substring function from stringr. [2 Marks]


ssadisability_long['month']<-substring(ssadisability_long[['month']],1,3)


# Q6 Convert Fiscal_Year from alphanumeric strings to actual years.
# For every "FY" that you find replace that with "20".
# Then use "01" as the day for each year and month
# and formulate a date column using lubridate. [5 Marks]

ssadisability_long$Fiscal_Year<-gsub("FY","20",ssadisability_long$Fiscal_Year)

ssadisability_long$Date<-dmy(paste("01",ssadisability_long$month,ssadisability_long$Fiscal_Year,sep=' '))

# Q7 Now as we have the new nicely formatted date column,
# Hence Remove Fiscal_Year and month columns (which are now redundant).
# Convert application_method to a factor.
# And widen back the dataset to have
# "Date","Internet" and "Total" as its columns. [Hint: Use spread function]
# [5 Marks]

ssadisability_long<-
  ssadisability_long %>%
  subset(., select = -c(Fiscal_Year,month)) %>%
  mutate(application_type=as.factor(application_type)) %>%
  spread(data = ., key = application_type, value = Applications)


# Q8 Add a column for the percentage of applications that were online.
# Plot the resulting percentage of applications thus made via the internet.
# Make sure to have the legends properly. Highlight the internet applications
# with Red color and rest all labels in the same color of Grey.
# Label the x- and y-axis properly using scales. Remove all the grids.
# [5 Marks]

ssadisability_long<-
  ssadisability_long %>%
  mutate(add_column(.,Percentage_of_Online = (Internet/Total)*100))%>%
  mutate(add_column(.,Percentage_of_Offine = 100 - Percentage_of_Online))

df_plot<-
ssadisability_long %>%
  pivot_longer(cols=c('Percentage_of_Online','Percentage_of_Offine'),
               names_to = "Appliaction_type",
               values_to = "Applications")

ggplot(df_plot, aes(x=Date, y=Applications, fill=Appliaction_type)) +
  geom_bar(stat="identity") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  scale_fill_manual(labels = c("Offline Applications", "Online Appliactions"), values = c("Grey","Red")) +
  scale_x_date(name="Date",date_minor_breaks = "1 months",date_labels = "%m-%Y") +
  ggtitle("Percentage of Applications by type") +
  ylab('% of Applications') +
  xlab('Date')




