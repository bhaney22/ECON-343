#This file provides all code and relevant output related to the following manuscript:
#A logistic regression investigation of the relationship between the Learning Assistant model 
#and failure rates in introductory STEM courses. 
#code will need to be adapted in order to load the data and "C_IJSE_Funs.R" files as well as output folders
################################################################################
#-------------------------Load data-------------------------------------------#
################################################################################
setwd("~/ECON 343/Logit example")
source("Alzen 2018 Funs.R")
x <- read_csv("~/ECON 343/Logit example/Alzen 2018 data.csv")

library(plyr)
library(lme4)
library(stargazer)
library(pscl)
library(lmtest)

################################################################################
#-----------------------------Raw Data Counts----------------------------------#
################################################################################
#figure 1
tmp<-ddply(x,.(course,term),counts.fun)
tmp<-t(tmp)
fig1<-as.data.frame(tmp)

#table 2
table(x$la_stud,x$fail)

################################################################################
#--------------------------------Descriptives----------------------------------#
################################################################################
#table 3 demographics
ddply(x,.(la_stud),dems.fun)

#table 3 t-tests
foo<-x[,c("id","la_stud","sex","nonwhite","first.gen","finaid_ever",
          "credits_entry","hs_gpa","act_new")]
pl<-foo[which(foo$la_stud=="1"),]
pnl<-foo[which(foo$la_stud=="0"),]
p.la<-unique(pl[!duplicated(pl),])#drops repeated lines
p.nola<-unique(pnl[!duplicated(pnl),])#drops repeated lines

t.test(p.la$sex,p.nola$sex)
t.test(p.la$nonwhite,p.nola$nonwhite)
t.test(p.la$first.gen,p.nola$first.gen)
t.test(p.la$finaid_ever,p.nola$finaid_ever)
t.test(p.la$credits_entry,p.nola$credits_entry)
t.test(p.la$hs_gpa,p.nola$hs_gpa)
t.test(p.la$act_new,p.nola$act_new)

################################################################################
#----------------------------------Regression----------------------------------# 
################################################################################
x$tchr_id<-as.factor(x$tchr_id)
x$ent_term<-as.factor(x$ent_term)
x$course<-as.factor(x$course)
m1<-glm(fail~0+la_stud+sex+nonwhite+first.gen+finaid_ever
        +zcredits_entry+zhsgpa+zact_new,
        data=x,family=binomial())
summary(m1)

m2<-glm(fail~0+la_stud+sex+nonwhite+first.gen+finaid_ever
        +zcredits_entry+zhsgpa+zact_new
        +relevel(course,ref="CHEM1111.1113")
        +relevel(ent_term,ref="20087")
        +relevel(tchr_id,ref="100"),
        data=x,family=binomial())
summary(m2)

m3<-glm(fail~0+la_stud+sex+nonwhite+first.gen+finaid_ever
        +zcredits_entry+zhsgpa+zact_new+la_stud*sex
        +relevel(course,ref="CHEM1111.1113")
        +relevel(ent_term,ref="20087")
        +relevel(tchr_id,ref="100"),
        data=x,family=binomial())
summary(m3)
pR2(m1)
pR2(m2)
pR2(m3)



stargazer(m1, m2, m3, type="html",
          dep.var.labels=c("Failed (=1)"),
          intercept.bottom = FALSE,
          intercept.top = TRUE,
          notes = "Models 2-3 suppress course, cohort, and instructor factor variables",
          covariate.labels=c("LA Exposure","Female","Nonwhite","First Generation",
                            "Financial Aid Recipient","Credits at Entry",
                           "HS GPA","ACT","LA Exposure*Female"), 
          omit=c("course","ent_term","tchr_id")
          )

# Add odds-ratios for the coefficients, instead of logits
# Add the confidence interval of the standard error
m1.OR.vector <- exp(m1$coef)
m1.CI.vector <- exp(confint(m1))
m1.p.values <- summary(m1)$coefficients[, 4]

m2.OR.vector <- exp(m2$coef)
m2.CI.vector <- exp(confint(m2))
m2.p.values <- summary(m2)$coefficients[, 4]

#m3 will take a long time to run
m3.OR.vector <- exp(m3$coef)
m3.CI.vector <- exp(confint(m3))
m3.p.values <- summary(m3)$coefficients[, 4]

stargazer(m1, m2, m3, type="html",
          ci=c(F,F), 
          intercept.bottom = F,
          intercept.top = T, 
          coef=c(list(m1.OR.vector),list(m2.OR.vector),list(m3.OR.vector)),
          ci.custom = c(list(m1.CI.vector),list(m2.CI.vector),list(m3.CI.vector)),
          p=c(list(m1.p.values),list(m2.p.values),list(m3.p.values)),
          star.cutoffs=c(0.05,0.01,0.001),
          dep.var.labels=c("Failed (=1)"),
          covariate.labels=c("LA Exposure","Female","Nonwhite","First Generation",
                             "Financial Aid Recipient","Credits at Entry",
                             "HS GPA","ACT","LA Exposure*Female"),
          omit=c("course","ent_term","tchr_id")
)
