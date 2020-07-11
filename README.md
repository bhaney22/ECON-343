# ECON-343
This repository contains the most up to date version of the Lecture, Homework template, and the Empirical Project Rmarkdown files.

**Instructions**
- Scroll up and click on the name of the folder (Lectures, Homework, or Empircal Project).
- Right-click on the .Rmd file and click "Save link as" to download it
- Or, you can double-click on the .Rmd file to open it 
  - Copy and paste the contents of the .Rmd file into a **new text file** in Rstudio 
  - Save the new file with the correct name and give it a **.Rmd** file extension


**See below for an index of R commands introduced in each Ch 00 R Lecture.Rmd file**

Ch 2 R Lecture.Rmd

- gf_histogram() for distributions of one variable
- gf_point()     for scatter plots of two variables
- lm()           to estimate a regression model
- stargazer()    to display estimated regression results
- coef()         to save the estimated coefficients from a regression
- fitted()       to save the predicted values from the regression ($\hat{y}$)


Ch 3 R Lecture.Rmd

- mutate():      to add variables to your dataset*
- cor():         for the correlation between two or more variables
- log():         for log transformation
- resid():       to save the uhats
- plot(resid()): to plot residuals


Ch 4 R Lecture.Rmd

- `summary()` to save the regression results
- r inline mini-chunk to display a regression result, or other computation
- linearHypothesis()  to conduct F-tests on regressions

Ch 6 R Lecture.Rmd

- I()
- scale()
- plot(effect())   to plot marginal effects
- data.frame()     to create xvariable values for input into predict()
- predict()
- predict( ,interval = "confidence" or "predict")

Ch 7 R Lecture.Rmd

- using mutate(case_when) to create dummy variables
- commands to evaluate dummy variable regressions (linear probability models)
