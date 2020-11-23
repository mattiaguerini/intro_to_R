# IMPORTING EUROSTAT DATA (without the EUROSTAT PACKAGE)

# you find here the commands with some comments

# NOTE: use the data in CSV that I sent you by email
# because it is much simpler than using the excel version.
# Before starting, save the data on your desktop!

# let's load the libraries that we will need
library(tidyverse)
library(readxl)


# then change the directory using the following command
setwd("~/Documents/GitHub/intro_to_R/data/")

setwd("~/Desktop/")
getwd()



# for people using Mac: this command should work fine
# for people using Windows: you might need to use the following
# setwd("C://Desktop/") 
# or something similar


# now load the data using the read_csv function
data_waste <- read_csv(file = "env_rwas_gen_1_Data.csv") %>% 
  # in the next line of code we remove the white spaces from the column "Values"
  # for example, the 1st line is recorded as "4 772.19" and we want it without the space
  # otherwise, when transforming this column to numeric we will get errors or even wrong values
  # to do this we use the function gsub.
  # to learn what the gsub does, use the help: ?gsub
  # note: mutate here is used to overwrite the variable/column "Value"
  mutate(Value = gsub(pattern = " ", replacement = "", x = Value)) %>% 
  # in the next line of code we tranform the values into doubles (real values)
  # this command will give us a Warning message, but that's ok! 
  # R is simply telling us that it has included some NA (thus we have missing values)
  mutate(Value = as.double(Value))

# that's it! I will keep you updated as soon as 
# the "eurostat" library will become available for download again



head(data_waste)

  
  
data_waste <- data_waste %>% 
  filter(TIME >= 2006 & TIME <= 2010) %>% 
  mutate(GEO = as.factor(GEO))

data_waste <- data_waste %>%
  group_by(GEO) %>% # grouping
  mutate(tot_values = sum(Value, na.rm = T)) %>%
  ungroup() %>% # remember to ungroup (to avoid unindented actions) 
  arrange(GEO, TIME)

sum_data_waste <- data_waste %>% 
  group_by(GEO) %>%
  summarise(max = max(Value, na.rm = T),
            mean = mean(Value, na.rm = T),
            n = n()) %>% 
  ungroup()

top3 <- data_waste %>% 
  filter(TIME == 2009) %>% 
  top_n(Value, n = 3) %>% 
  select(GEO, Value)

bottom3 <- data_waste %>% 
  filter(TIME == 2009) %>% 
  top_n(Value, n = -3)
