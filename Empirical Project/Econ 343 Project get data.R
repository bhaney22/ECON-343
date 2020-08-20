library(dplyr)      # for filter and select commands. etc.
library(foreign)      # apply_labels() calc_cro()
library(ggformula)
library(expss)
library(stargazer)  # formatted regression tables


## Download GSS dataset in SPSS format from the GSS website:

temp1 <- tempfile()
download.file("https://gss.norc.org/Documents/spss/2018_spss.zip", temp1)
unzip(temp1,"GSS2018.sav")
unlink(temp1)
rm(temp1)

##
## Read the .spss dataset into R
##

tmp.spss <- foreign::read.spss("GSS2018.sav",
                                   use.value.labels = FALSE,
                                   max.value.labels = FALSE,
                                   to.data.frame = FALSE,
                                   use.missings = TRUE) 


## Save original variable names and labels

    var_names = names(tmp.spss)
    var_labs = attr(tmp.spss,'variable.labels')
    
## apply Value Labels
    attr(tmp.spss,'label.table') = NULL
    if(anyNA(var_names)){
        var_names = make.names(var_names, unique = TRUE)
        names(tmp.spss) = var_names
        names(var_labs) = var_names
    }
    for (var_name in names(var_labs)) {
            curr_lab = var_labs[[var_name]]
            if (length(curr_lab)>0 && (curr_lab!="") && !is.na(curr_lab)) var_lab(tmp.spss[[var_name]]) = curr_lab
    }
    
## apply Variable Labels    
    for (var_name in names(tmp.spss)) {
        # Trim whitespaces from start and end of character variables
        if (is.character(tmp.spss[[var_name]])) {
            tmp.spss[[var_name]] = trimws(tmp.spss[[var_name]])
            tmp.spss[[var_name]][tmp.spss[[var_name]] %in% ""] = NA
        }    
        val_labs = attr(tmp.spss[[var_name]],"value.labels")
        if (length(val_labs)>0) {
            attr(tmp.spss[[var_name]],"value.labels") = NULL
            if (is.character(val_labs)){
                temp = utils::type.convert(val_labs, numerals = "no.loss")
                if(is.numeric(temp)) {
                    val_labs = setNames(temp, names(val_labs))
                }
            }
            val_lab(tmp.spss[[var_name]]) = val_labs
            
        }	
    }


tmp.spss <- as.data.frame(tmp.spss)
save(tmp.spss, file = "GSS2018.Rdata")

