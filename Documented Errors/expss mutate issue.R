# https://github.com/tidyverse/dplyr/issues/5424#issue-660888298
# https://github.com/gdemin/expss/issues/68 (CLOSED - haven problem)

# I believe this is related to this haven::labelled_spss open issue:
# https://github.com/tidyverse/haven/issues/534#issue-656435577


library(reprex)

reprex({
library(haven)
library(expss)
library(dplyr)

var1 <- haven::labelled(c(0, 1, 9, 0, 0),c('No' = 0, 'Yes' = 1, 'DK' = 9))
var2 <- haven::labelled(c(0, 1, 2, 3, 1), c('DK' = 0, 'first' = 1, 'second' = 2, 'third' = 3))
mytest <- tibble(var1,var2)

str(attributes(mytest$var1))
str(attributes(mytest$var2))

mytest$var1   <- expss::mis_val(mytest$var1, c(9))
mytest$var2   <- expss::mis_val(mytest$var2, c(0), with_labels = TRUE)

str(attributes(mytest$var1))
str(attributes(mytest$var2))

mytest <- mytest %>%
  mutate(newvar1 = case_when(var1 == 1 ~ 1, var1 ==0 ~ 2)) 

mytest <- mytest %>%
   mutate(newvar2 = case_when(var2 == 1 ~ 1, var2 == 2  ~ 0)) 

rlang::last_error()

rlang::last_trace()

class(mytest$var2) = setdiff(class(mytest$var2), "vctrs_vctr")

str(attributes(mytest$var1))
str(attributes(mytest$var2))

mytest <- mytest %>%
  mutate(newvar2 = case_when(var2 == 1 ~ 1, var2 == 2  ~ 0)) 

# sessionInfo()
})

