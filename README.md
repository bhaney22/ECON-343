# ECON-343
This repository contains the most up to date version of the Lecture, Homework template, and the Empirical Project Rmarkdown files.

**Instructions**
- Scroll up and click on the name of the folder (Lectures, Homework, or Empircal Project).
- Click on the .Rmd file to open it
- Copy and paste the contents of the .Rmd file into a new file in Rstudio **OR**
- Download the .Rmd file to your computer and then upload to Rstudio


**R commands introduced in each chapter lecture**

Ch 2 R Lecture

- gf_histogram() for distributions of one variable
- gf_point()     for scatter plots of two variables
- lm()           to estimate a regression model
- stargazer()    to display estimated regression results
- coef()         to save the estimated coefficients from a regression
- fitted()       to save the predicted values from the regression ($\hat{y}$)


Ch 3 R Lecture

- mutate():      to add variables to your dataset*
- cor():         for the correlation between two or more variables
- log():         for log transformation
- resid():       to save the uhats
- plot(resid()): to plot residuals


Ch 4 R Lecture

- `summary()` to save the regression results
- r inline mini-chunk to display a regression result, or other computation
- linearHypothesis()  to conduct F-tests on regressions

Ch 6 R Lecture

- I()
- scale()
- plot(effect())   to plot marginal effects
- data.frame()     to create xvariable values for input into predict()
- predict()
- predict( ,interval = "confidence" or "predict")
