library(lubridate) 
library(Rmisc)
#library("ggplot2", lib.loc="~/R/win-library/3.3")
library(readr)
library(tidyverse)
filterCSV<-function(name,rep){
  counterHopsMsgRx <- rep(0,rep)
  for (i in 0:rep){
    x0 <- read.csv(file =paste(name,'-',as.character(i),".csv",sep=''))
    x0 <- x0 %>% filter(name == "hopCount:stats")
    x0 <- x0 %>% filter(!is.na(max))
    counterHopsMsgRx[i+1] <- as.numeric(max(x0 %>% select(max)))
    
  }
  return(counterHopsMsgRx)
}

filterCSVparam<-function(name,rep,attr){
  MITM<- rep(0,rep)
  for (i in 0:rep)    
    x0 <- read.csv(file =paste(name,'-',as.character(i),".csv",sep=''))
  return(x0)
}

function(name,rep,attr)