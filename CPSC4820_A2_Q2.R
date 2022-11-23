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


# Q2 Read and view the ssadisability dataset properly. [2 Marks]



# Q3 As you might see most of the data is redundant and tells similar info.
# For each month the dataset has one Total and one Internet coloumn.
# Total for that month represents the total applications received for disability benefits.
# Internet represents applications received for disability benefits online.
# So now convert this wide data into a long data having only
# "Fiscal_Year", "month" and "Applications" column. [5 Marks]










# Q4 Now Split the month and application type. 
# That means now there will be 4 columns. 
# The type column will show either total or internet. [3 Marks]






# Q5 If you now look at the months column, 
# there are some months which have 3 char representation like "Oct".
# Whereas some have more than 3 characters in them.
# Now trim all the months to have 3 characters. Do not hard code.
# Use substring function from stringr. [2 Marks]





# Q6 Convert Fiscal_Year from alphanumeric strings to actual years. 
# For every "FY" that you find replace that with "20".
# Then use "01" as the day for each year and month 
# and formulate a date column using lubridate. [5 Marks]







# Q7 Now as we have the new nicely formatted date column,
# Hence Remove Fiscal_Year and month columns (which are now redundant).
# Convert application_method to a factor.
# And widen back the dataset to have 
# "Date","Internet" and "Total" as its columns. [Hint: Use spread function]
# [5 Marks]











# Q8 Add a column for the percentage of applications that were online.
# Plot the resulting percentage of applications thus made via the internet.
# Make sure to have the legends properly. Highlight the internet applications
# with Red color and rest all labels in the same color of Grey. 
# Label the x- and y-axis properly using scales. Remove all the grids.
# [5 Marks]









