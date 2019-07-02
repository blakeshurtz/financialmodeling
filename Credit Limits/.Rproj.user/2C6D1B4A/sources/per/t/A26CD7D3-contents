###LoanStats_2018.csv is for loans that were accepted; RejectStats_2018Q1.csv is for loans that were rejected
#data is for Q1 2018
#original data can be downloaded here: https://www.lendingclub.com/info/download-data.action
#for both datasets, first row was removed (link to prospectus)
#for LoanStats_2018Q1.csv, the first two columns- id and memberid- were all empty. these columns were removed manually
setwd("./data")
accepted <- read.csv("LoanStats_2018Q1.csv")

###select relevant variables. 
#This dataset is primarily focused on loans, but also includes variables that are relevant to credit cards.
#in particular "bc" in the variable name indicates "bank card". #variables are sorted alphebetically
accepted <- accepted %>% select(bc_util, 
                                percent_bc_gt_75, 
                                total_bc_limit, 
                                bc_open_to_buy,
                                max_bal_bc, 
                                mths_since_recent_bc, 
                                #mths_since_recent_bc_dlq #remove for now, too many missing observations
                                ) %>% arrange()
                                

###summarise data
library(skimr)
#convert all variables to numeric in order to make skim() easier to read
col_names <- names(accepted)
accepted[,col_names] <- lapply(accepted[,col_names], as.numeric)
#skim it- what variables deserve further consideration?
skim(accepted)

###description of included variables (from data dictionary) is below
'
bc_open_to_buy	            Total open to buy on revolving bankcards. (WTF does this mean?)
bc_util	                    Ratio of total current balance to high credit/credit limit for all bankcard accounts. #bank card utilization- KEY
max_bal_bc	                Maximum current balance owed on all revolving accounts #all accounts?
mths_since_recent_bc	      Months since most recent bankcard account opened. #predictor for regression
mths_since_recent_bc_dlq	  Months since most recent bankcard delinquency #predictor for regression
percent_bc_gt_75	          Percentage of all bankcard accounts > 75% of limit. #predictor for regression
total_bc_limit	            Total bankcard high credit/credit limit #credit limit. damn these are high- but these arent ccs
'

###remove missing data
acceptedcomplete <- accepted[complete.cases(accepted),]
acceptedNAs <- accepted[!complete.cases(accepted),]


###import rejected? maybe not a good idea, since the variables are so differed
#rejected <- read.csv("RejectStats_2018Q1.csv")

###exit script
setwd("..")


