# expss mutate test.r
# author: Becky Haney
# date:   July 18, 2020
#
# Description:
# Code used as minimum working example for these two issues:

# https://github.com/tidyverse/dplyr/issues/5424#issue-660888298
# https://github.com/gdemin/expss/issues/68#issue-659687025

library(haven)
library(expss)
library(dplyr)

# Labels using expss apply_label
var1x <- c(0, 1, 9, 0, 0)
var2x <- c(0, 1, 2, 3, 1)

mytestx <- tibble(var1x,var2x)

mytestx <- expss::apply_labels(mytestx, 
                              var1x = c(`No` = 0, `Yes` = 1, `DK` = 9),
                              var2x = c(`DK` = 0, `first` = 1, `second` = 2, `third` = 3))

# Classes for expss labeled variables
str(attributes(mytestx$var1x))
str(attributes(mytestx$var2x))

mytestx$var1x   <- expss::mis_val(mytestx$var1x, c(9))
mytestx$var2x   <- expss::mis_val(mytestx$var2x, c(0), with_labels = TRUE)

# Classes for expss labeled variables after mis_val command
str(attributes(mytestx$var1x))
str(attributes(mytestx$var2x))

#
# Using haven package labels
# 

var1 <- haven::labelled(c(0, 1, 9, 0, 0),c(`No` = 0, `Yes` = 1, `DK` = 9))
var2 <- haven::labelled(c(0, 1, 2, 3, 1), c(`DK` = 0, `first` = 1, `second` = 2, `third` = 3))

mytest <- tibble(var1,var2)


# Classes for haven-labelled variables
str(attributes(mytest$var1))
str(attributes(mytest$var2))

mytest$var1   <- expss::mis_val(mytest$var1, c(9))
mytest$var2   <- expss::mis_val(mytest$var2, c(0), with_labels = TRUE)

# Classes for haven-labelled variables after expss::mis_val command
# WITHOUT using with_labels = TRUE option
str(attributes(mytest$var1))

# WITH using with_labels = TRUE option
# This variable's set of classes do not work with mutate()
str(attributes(mytest$var2))

mytest <- mytest %>%
  mutate(newvar1 = case_when(var1 == 1 ~ 1,
                             var1 != 1 ~ 0))

# The combination of classes for the "with_label = TRUE" variable 
# causes an error in the mutate() command

# Running the following command produces the error:
#   Error: Problem with `mutate()` input `newvar2`.
#   x Can't combine `..1` <labelled<double>> and `..2` <double>.
#   ℹ Input `newvar2` is `case_when(var2 == 1 ~ 1, var2 != 1 ~ 0)`.


mytest <- mytest %>%
  mutate(newvar2 = case_when(var2 == 1 ~ 1,
                             var2 == 2 | var2 == 3 ~ 0)) 

# Removing the "labelled" attribute from var2 fixes the error
attributes(mytest$var2)$class <- 
  c("haven_labelled", "vctrs_vctr", "double")

mytest <- mytest %>%
  mutate(newvar2 = case_when(var2 == 1 ~ 1,
                             var2 == 2 | var2 == 3 ~ 0)) 

mytest <- mytest %>%
  mutate(newvar1 = case_when(var1 == 1 ~ 1, var1 ==0 ~ 2)) 

# Summary
## The following classes work with mutate()
### "labelled" "numeric"
str(attributes(mytestx$var1x))
str(attributes(mytestx$var2x))

### "haven-labelled" "double"
str(attributes(mytest$var1))

## This set of classes does not work with mutate()
### "labelled" "haven-labelled" "double"
str(attributes(mytest$var2))

### The last set of classes results from creating labels using
### haven::labelled to create labels THEN using
### expss::mis_val( , with_labels = TRUE) on the variable

### The above workflow is typical for reading in a .SAV file
### then recoding missings and creating new variables



