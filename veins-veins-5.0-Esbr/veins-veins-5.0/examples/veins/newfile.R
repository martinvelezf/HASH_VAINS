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
getResults<-function(name,rep){
  n=3
  attr=c("MTIMSignal:count","warningReceivedSignal:count","preventMsgSignal:count","corruptedMsgGenerateSignal:count","generatedWSMs")
  Data<- matrix(rep(0,10*n),ncol=n)
  Data1<- matrix(rep(0,10*n),ncol=n)
  Data2<- matrix(rep(0,10*n),ncol=n)
  rownames(Data)<-c(0:9*10)
  colnames(Data)<-c("Relation of the mean corrupted message","Porcentaje of mean mitm messaje detected")
  colnames(Data1)<-c("Relation of the mean corrupted message","Porcentaje of min mitm messaje detected")
  colnames(Data2)<-c("Relation of the mean corrupted message","Porcentaje of max mitm messaje detected")
  for(i in 0:9){
    file=paste(name,as.character(i*10),sep='')
    print(file)
    data=filterCSVparam(file,rep,attr)
    
      Data[i+1,1]=mean(data[,1]/data[,2])
      Data1[i+1,1]=min(data[,1]/data[,2])
      Data2[i+1,1]=max(data[,1]/data[,2])
      
      Data[i+1,2]=mean(data[,3]/data[,2])
      Data1[i+1,2]=min(data[,3]/data[,2])
      Data2[i+1,2]=max(data[,3]/data[,2])
  }
  return(data.frame(Data,Data1,Data2))
}
%numero de  mesnajes corruptos corruptedMsgSignal:count%
name1="results/PreventMITM"
R=getResults(name1,10)

hash=(0:9)*10

Results=data.frame(hash,minmitm,maxmitm,meanmitm)

Results%>%
gather(key,value,MTIMSignal.count.1,MTIMSignal.count,MTIMSignal.count.2) %>%
  ggplot(aes(x=hash, y=value, colour=key))+geom_line(lwd=1.25)+geom_point()

ggplot(Results,aes(hash,detected))+geom_line(lwd=1.25)+geom_point()










name1="results/PreventMITM0"
attr=c("MTIMSignal:count","corruptedMsgSignal:count","warningReceivedSignal:count")


mitm=filterCSVparam(name,100,attr)
prvent=filterCSVparam(name1,100,attr1)


