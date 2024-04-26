Library(tidyverse)
View(CustomerDemographicData)

#Task 3. Data cleaning and preprocessing

#CustomerDemographicData
#Removing empty rows and columns
library(janitor)
dataSet1 <- clean_names(CustomerDemographicData)
dataSet1
dataSet3 <- remove_empty(dataSet1, which = c("rows", "cols"), quiet = FALSE)
dataSet3

#Removing duplicate rows and columns
library(dplyr)
data1_cleaned <- distinct(dataSet3)
data1_cleaned
CustomerDemographicData_cleaned <- data1_cleaned
CustomerDemographicData_cleaned

#InStoreSalesData
View(InStoreSalesData)
library(janitor)
Store1 <- clean_names(InStoreSalesData)
Store1

library(dplyr)
InStoreSalesData_cleaned <- distinct(Store1)
InStoreSalesData_cleaned
InStoreSalesData_cleaned2 <- distinct(InStoreSalesData_cleaned, product, .keep_all = TRUE)
InStoreSalesData_cleaned2

#OnlineSalesData
View(OnlineSalesData)
library(janitor)
Online1 <- clean_names(OnlineSalesData)
Online1


library(dplyr)
Online2 <- distinct(Online1)
Online2
OnlineSalesData_cleaned <- Online2
OnlineSalesData_cleaned

# Check the column names in CustomerDemographicData_cleaned
colnames(CustomerDemographicData_cleaned)

# Check the column names in InStoreSalesData_cleaned2
colnames(InStoreSalesData_cleaned2)


#Task 4: Perform Data Merge and Integration
Sales_merge <- merge(CustomerDemographicData_cleaned, InStoreSalesData_cleaned2, OnlineSalesData_cleaned,
                     by = c("customer_id"))

Sales_merge <- merge(CustomerDemographicData_cleaned, 
                     InStoreSalesData_cleaned2, 
                     by = "customer_id")

Sales_merge2 <- merge(Sales_merge, 
                     OnlineSalesData_cleaned, 
                     by = "customer_id")

Sales_merge
View(Sales_merge)
View(Sales_merge2)

summary(Sales_merge2)  #Summary of statistics

library(skimr)
skim(Sales_merge2) #Perform skim to display summary statistics

#Task 5: Perform Data Analysis
#Performance of EDA
library(tidyverse)
library(explore)

Sales_merge2 %>% explore() #exploring dataset

Sales_merge2 %>% describe_all()  #Describing variables in the dataset
 
#visualising statistics
Sales_merge2 %>% 
  report(
    target = gender,
    output_dir = "C:/Users/william88/Documents/R coursework/",
    output_file = "gender.html"
  )

Sales_merge2 %>% 
  report(
    target = age,
    output_dir = "C:/Users/william88/Documents/R coursework/",
    output_file = "ageStatistics.html"
  )

Sales_merge2 %>% 
  report(
    target = income_level,
    output_dir = "C:/Users/william88/Documents/R coursework/",
    output_file = "incomeLevelstatistics.html"
  )

#Task 6: Checking for data integrity and consistency
library(dplyr)
data <- Sales_merge2

# Check for missing values
missing_values <- sapply(data, function(x) sum(is.na(x)))
print("Missing Values:")
print(missing_values)

# Check for duplicates
duplicates <- data[duplicated(data), ]
if (nrow(duplicates) > 0) {
  print("Duplicate Rows:")
  print(duplicates)
} else {
  print("No Duplicate Rows Found.")
}

# Check consistency of categorical variables
categorical_vars <- c("gender", "income_level", "location", "store_location", "product.x", "product.y")
for (var in categorical_vars) {
  unique_values <- unique(data[[var]])
  print(paste("Unique values for", var, ":"))
  print(unique_values)
}

# Check summary statistics for numerical variables
summary_stats <- summary(data)
print("Summary Statistics:")
print(summary_stats)

# Task 7. Data Cleaning and Merging Process Documentation:

# Step 1: Data Cleaning for Customer Demographic Data
# - Loaded the tidyverse library for data manipulation.
# - Viewed the CustomerDemographicData to understand its structure.
# - Cleaned column names and removed empty rows and columns using the janitor package.
# - Removed duplicate rows using the distinct function from dplyr.
# - Saved the cleaned dataset as CustomerDemographicData_cleaned.

# Step 2: Data Cleaning for In-Store Sales Data
# - Viewed the InStoreSalesData to understand its structure.
# - Cleaned column names and removed duplicate rows using the janitor package and dplyr.
# - Saved the cleaned dataset as InStoreSalesData_cleaned2.

# Step 3: Data Cleaning for Online Sales Data
# - Viewed the OnlineSalesData to understand its structure.
# - Cleaned column names and removed duplicate rows using the janitor package and dplyr.
# - Saved the cleaned dataset as OnlineSalesData_cleaned.

# Step 4: Merging Datasets
# - Merged CustomerDemographicData_cleaned with InStoreSalesData_cleaned2 using customer_id as the key.
# - Merged the result with OnlineSalesData_cleaned using customer_id as the key.
# - Saved the final merged dataset as Sales_merge2.

# Step 5: Exploratory Data Analysis (EDA)
# - Explored Sales_merge2 using the explore function from the explore package.
# - Described variables in Sales_merge2 using describe_all function from dplyr.

# Step 6: Visualizing Statistics
# - Generated separate reports for gender, age, and income_level statistics using the report function.

# Step 7: Checking Data Integrity
# - Checked for missing values, duplicates, and unique values in categorical variables.
# - Calculated summary statistics for numerical variables using the summary function.

# End of Data Merge and Integration Process Documentation.
