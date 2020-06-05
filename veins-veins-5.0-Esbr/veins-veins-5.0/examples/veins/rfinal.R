library(lubridate) 
library(Rmisc)
library(ggplot2)
library(readr)
library(tidyverse)


filterCSVparam<-function(name,rep,attr){
  n=length(attr)
  Data<- matrix(rep(0,(rep)*n),ncol=n)
  colnames(Data)<-attr
  for (i in 1:rep){
    fl=paste(name,'-#',as.character(i-1),".csv",sep='')
    #print(fl)
    tryCatch(
      expr = {
        x0 <- read.csv(file =fl)
        x0=x0 %>% filter( is.na(value)==FALSE)
        x0=x0 %>% filter( (value)!=0)
        for(j in 1:n){
          x1=x0 %>% filter( name== attr[j])
          if(attr[j]=="delay:count")
            Data[i,j]=mean(x1$value) 
          else
            Data[i,j]=sum(x1$value)  
        }
      },
      error = function(e){ 
        print(fl)
      })
  }
  return(Data)
}
      
attr=c("delay","MTIMSignal:count","warningReceivedSignal:count","preventMsgSignal:count")      
#"corruptedMsgGenerateSignal:count","generatedWSMs"      
name="results/PreventMITM90";
filterCSVparam(name,10,attr)
getResultskm<-function(name,rep){
    carkm2<-c(10,25,50,75,100)
    len=length(carkm2)
    attr=c("MTIMSignal:count","warningReceivedSignal:count","preventMsgSignal:count")
     MSG=data.frame()
    P=data.frame()
    for(i in 1:len){
      file=paste(name,as.character(carkm2[i]),sep='')
      print(file)
      data=filterCSVparam(file,rep,attr)
      Rdetected=data[,3]/data[,2]
      Rcorrupted=data[,1]/data[,2]
      
      data=data.frame(data)
      data=data%>%gather(key,value)
      percent=((1:(len*30)) * 0 )+carkm2[i]
      data=data.frame(percent,data)
      
      
      Data=data.frame(Rdetected,Rcorrupted)
      Data=Data%>%gather(key,value)
      percent=((1:(len*20)) * 0 )+carkm2[i]
      Data=data.frame(percent,Data)
      
      
      if (i==1){
        MSG =data
        P=Data
      }
      else{
        MSG=MSG %>% add_row(data)
        P=P%>% add_row(Data)
      }
      
    }
    return(list("m" = MSG, "p" = P))
  }
  
R1=getResultskm("perkm/results/PreventMITM",10)
write.csv(R1$m,"results/Mperkm.csv")
write.csv(R1$p,"results/Pperkm.csv")




pg <- PlantGrowth    # Copy data into new data frame
# Rename the column and the values in the factor
levels(pg$group)[levels(pg$group)=="ctrl"] <- "Control"
levels(pg$group)[levels(pg$group)=="trt1"] <- "Treatment 1"
levels(pg$group)[levels(pg$group)=="trt2"] <- "Treatment 2"












getResults<-function(name,rep){
        n=5
        attr=c("MTIMSignal:count","warningReceivedSignal:count","preventMsgSignal:count")
        MSG=data.frame()
        P=data.frame()
        for(i in 0:9){
          file=paste(name,as.character(i*10),sep='')
          print(file)
          data=filterCSVparam(file,rep,attr)
          
          Rdetected=data[,3]/data[,2]
          Rcorrupted=data[,1]/data[,2]
          
          data=data.frame(data)
          data=data%>%gather(key,value)
          percent=((1:30) * 0 )+i*10
          data=data.frame(percent,data)
          
          
          Data=data.frame(Rdetected,Rcorrupted)
          Data=Data%>%gather(key,value)
          percent=((1:20) * 0 )+i*10
          Data=data.frame(percent,Data)
          
          
          if (i==0){
            MSG =data
            P=Data
          }
          else{
            MSG=MSG %>% add_row(data)
            P=P%>% add_row(Data)
          }
        }
        return(list("m" = MSG, "p" = P))
      }
      

R=getResults("50/results/PreventMITM",10)
write.csv(R$m,"results/M.csv")
write.csv(R$p,"results/P.csv")

##############################POrcentaje##################3333
