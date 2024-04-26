Library(tidyverse)
View(CustomerDemographicData)

#Data cleaning

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


#Merging DataSets
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

library(tidyverse)
library(explore)

Sales_merge2 %>% explore()

Sales_merge2 %>% describe_all()
 
Sales_merge2 %>% 
  report(
    target = gender,
    output_dir = "C:/Users/william88/Documents/R coursework/",
    output_file = "gender.html"
  )
