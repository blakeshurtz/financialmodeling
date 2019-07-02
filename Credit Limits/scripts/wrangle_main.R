library(tidyverse)
library(lubridate)
library(data.table)
library(readr)

getwd() #be in project directory
###import both datasets (accepted and rejected) and remove unnecessary variables
source('scripts/import_data.r')

#analyze data
source('analysis')