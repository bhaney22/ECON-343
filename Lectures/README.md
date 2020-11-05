# ECON-343

## Index of R commands introduced in each R Lecture

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

to create dummy variables:

- mutate()
- if_else()
- case_when()
- plot(effect())

Ch 10 R Lecture.Rmd

- tsdata <- ts(dsname, start=yyyy) - make time series data
- `dynlm()` is time Series version of `lm()`
- lm <- dynlm(y ~ x1 + L(x1) + L(x1,2) + x2, data=tsdata) - Lags
- trend(tsdata) - trends in regression model
