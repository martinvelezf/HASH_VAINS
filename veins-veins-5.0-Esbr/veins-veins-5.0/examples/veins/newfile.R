library(lubridate) 
library(Rmisc)
library(ggplot2)
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
  n=length(attr)
  Data<- matrix(rep(0,(rep)*n),ncol=n)
  colnames(Data)<-attr
  for (i in 1:rep){
    fl=paste(name,'-#',as.character(i-1),".csv",sep='')
    #print(fl)
    x0 <- read.csv(file =fl)
    x0=x0 %>% filter( is.na(value)==FALSE)
    for(j in 1:n){
      x1=x0 %>% filter( name== attr[j])
      Data[i,j]=sum(x1$value)  
    }
  }
  return(Data)
}
getResults<-function(name,attr,rep){
  n=length(attr)
  Data<- matrix(rep(0,10*n),ncol=n)
  Data1<- matrix(rep(0,10*n),ncol=n)
  Data2<- matrix(rep(0,10*n),ncol=n)
  rownames(Data)<-c(0:9*10)
  colnames(Data)<-attr
  rownames(Data1)<-c(0:9*10)
  colnames(Data1)<-attr
  rownames(Data2)<-c(0:9*10)
  colnames(Data2)<-attr
  for(i in 0:9){
    file=paste(name,as.character(i*10),sep='')
    print(file)
    data=filterCSVparam(file,rep,attr)
    for(j in 1:n){
      Data[i+1,j]=mean(data[,j])
      Data1[i+1,j]=min(data[,j])
      Data2[i+1,j]=max(data[,j])
    }
  }
  return(data.frame(Data,Data1,Data2))
}

name1="results/PreventMITM"
attr1=c("MTIMSignal:count","corruptedMsgSignal:count","warningReceivedSignal:count","preventMsgSignal:count","corruptedMsgGenerateSignal:count","generatedWSMs")

R=getResults(name1,attr1,10)
hash=(0:9)*10
meanmitm=R[1]/R[3]
maxmitm=R[7]/R[9]
minmitm=R[13]/R[15]

detected=R[,4]/R[,1]
Results=data.frame(hash,minmitm,maxmitm,meanmitm)

Results%>%
gather(key,value,MTIMSignal.count.1,MTIMSignal.count,MTIMSignal.count.2) %>%
  ggplot(aes(x=hash, y=value, colour=key))+geom_line(lwd=1.25)+geom_point()

ggplot(Results,aes(hash,detected))+geom_line(lwd=1.25)+geom_point()










name1="results/PreventMITM0"
attr=c("MTIMSignal:count","corruptedMsgSignal:count","warningReceivedSignal:count")


mitm=filterCSVparam(name,100,attr)
prvent=filterCSVparam(name1,100,attr1)


