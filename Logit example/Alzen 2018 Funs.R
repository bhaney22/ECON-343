#This file includes the functions used for data analysis in the manuscript titled:
#A logistic regression investigation of the relationship between the Learning Assistant model and failure rates in introductory STEM courses 

#######################################################################
#--------------------Cleaning and Demographics------------------------#
#######################################################################

#counts of students in each course and failure rates
counts.fun<-function(x){
  #number of students in the class
  n<-length(unique(x$id))
  #number of LA students
  t1<-x[which(x$la_stud=="1"),]
  numla<-length(unique(t1$id))
  #number of non-la students
  t2<-x[which(x$la_stud=="0"),]
  numnola<-length(unique(t2$id))
  #number of la students who fail
  t3<-t1[which(t1$fail=="1"),]
  num_la_fail<-length(unique(t3$id))
  #number of nola students who fail
  t4<-t2[which(t2$fail=="1"),]
  num_nola_fail<-length(unique(t4$id))
  #% of students who fail
  pfail_la<-round(num_la_fail/numla,2)
  pfail_nola<-round(num_nola_fail/numnola,2)
  y<-cbind(n,numla,numnola,num_la_fail,num_nola_fail,pfail_la,pfail_nola)
  y
}


#tables of instructors & students to find those with BOTH la & nola
prof.count.fun<-function(x){
  table(droplevels(x$instr_ns),x$la_stud)
}

#demographics tables
dems.fun<-function(x){
  t1<-x[,c("id","sex","nonwhite","first.gen","finaid_ever","credits_entry",
           "hs_gpa","act_new","fail")]
  y<-t1[!duplicated(t1$id),]
  n<-length(unique(y$id))
  sex<-round(prop.table(table(y$sex))*100,0)
  nonwhite<-round(prop.table(table(y$nonwhite))*100,0)
  first.gen<-round(prop.table(table(y$first.gen))*100,0)
  fin.aid<-round(prop.table(table(y$finaid_ever))*100,0)
  mean.ent.cred<-round(mean(y$credits_entry,na.rm=TRUE))
  sd.ent.cred<-round(sd(y$credits_entry,na.rm=TRUE))
  mean.hsgpa<-round(mean(y$hs_gpa,na.rm=TRUE),2)
  sd.hsgpa<-round(sd(y$hs_gpa,na.rm=TRUE),2)
  mean.test<-round(mean(y$act_new,na.rm=TRUE))
  sd.test<-round(sd(y$act_new,na.rm=TRUE))
  
  
  my.list<-rbind(n,sex,nonwhite,first.gen,fin.aid,mean.ent.cred,sd.ent.cred,
                mean.hsgpa,sd.hsgpa,mean.test,sd.test)
  my.list
  
}

#Standardize continuous variables for regression
stand.fun<-function(x){
  t1<-mean(x$hs_gpa,na.rm=TRUE)
  t2<-sd(x$hs_gpa,na.rm=TRUE)
  x$zhsgpa<-(x$hs_gpa-t1)/t2
  
  t3<-mean(x$act_new,na.rm=TRUE)
  t4<-sd(x$act_new,na.rm=TRUE)
  x$zact_new<-(x$act_new-t3)/t4
  
  t5<-mean(x$credits_entry,na.rm=TRUE)
  t6<-sd(x$credits_entry,na.rm=TRUE)
  x$zcredits_entry<-(x$credits_entry-t5)/t6
  x
}