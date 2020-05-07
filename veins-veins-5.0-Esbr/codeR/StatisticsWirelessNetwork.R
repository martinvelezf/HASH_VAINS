library(lubridate) 
library(Rmisc)
library("ggplot2", lib.loc="~/R/win-library/3.3")
library(readr)
library(tidyverse)

#################################################
setwd("/opt/veins-veins-5.0/examples/veins/results")
#################################################


#write.csv(x0, file = 'datosVeins.csv')

x0 <- read.csv(file = 'Counter-#0.csv')
x0 <- x0 %>% filter(name == "warningReceivedSignal:count")
x0 <- x0 %>% filter(type == "scalar")
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(value)))

x1 <- read.csv(file = 'Counter-#1.csv')
x1 <- x1 %>% filter(name == "warningReceivedSignal:count")
x1 <- x1 %>% filter(type == "scalar")
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(value)))


x2 <- read.csv(file = 'Counter-#2.csv')
x2 <- x2 %>% filter(name == "warningReceivedSignal:count")
x2 <- x2 %>% filter(type == "scalar")
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(value)))


x3 <- read.csv(file = 'Counter-#3.csv')
x3 <- x3 %>% filter(name == "warningReceivedSignal:count")
x3 <- x3 %>% filter(type == "scalar")
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(value)))

x4 <- read.csv(file = 'Counter-#4.csv')
x4 <- x4 %>% filter(name == "warningReceivedSignal:count")
x4 <- x4 %>% filter(type == "scalar")
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(value)))

x5 <- read.csv(file = 'Counter-#5.csv')
x5 <- x5 %>% filter(name == "warningReceivedSignal:count")
x5 <- x5 %>% filter(type == "scalar")
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(value)))


x6 <- read.csv(file = 'Counter-#6.csv')
x6 <- x6 %>% filter(name == "warningReceivedSignal:count")
x6 <- x6 %>% filter(type == "scalar")
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(value)))


x7 <- read.csv(file = 'Counter-#7.csv')
x7 <- x7 %>% filter(name == "warningReceivedSignal:count")
x7 <- x7 %>% filter(type == "scalar")
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(value)))


x8 <- read.csv(file = 'Counter-#8.csv')
x8 <- x8 %>% filter(name == "warningReceivedSignal:count")
x8 <- x8 %>% filter(type == "scalar")
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(value)))

x9 <- read.csv(file = 'Counter-#9.csv')
x9 <- x9 %>% filter(name == "warningReceivedSignal:count")
x9 <- x9 %>% filter(type == "scalar")
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(value)))



vectorFloodingcounterHopsMsgRx40<-c(counterHopsMsgRx0,
                               counterHopsMsgRx1,
                               counterHopsMsgRx2,
                               counterHopsMsgRx3,
                               counterHopsMsgRx4,
                               counterHopsMsgRx5,
                               counterHopsMsgRx6,
                               counterHopsMsgRx7,
                               counterHopsMsgRx8,
                               counterHopsMsgRx9)
############################################################################

x0 <- read.csv(file = 'ForwardingGame-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'ForwardingGame-1.csv')
x1 <- x0 %>% filter(name == "hopCount:stats")
x1 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'ForwardingGame-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'ForwardingGame-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'ForwardingGame-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'ForwardingGame-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))

x6 <- read.csv(file = 'ForwardingGame-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))

x7 <- read.csv(file = 'ForwardingGame-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))

x8 <- read.csv(file = 'ForwardingGame-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))

x9 <- read.csv(file = 'ForwardingGame-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))


vectorForwardingGamecounterHopsMsgRx40<-c(counterHopsMsgRx0,
                                     counterHopsMsgRx1,
                                     counterHopsMsgRx1,
                                     counterHopsMsgRx3,
                                     counterHopsMsgRx4,
                                     counterHopsMsgRx5,
                                     counterHopsMsgRx6,
                                     counterHopsMsgRx7,
                                     counterHopsMsgRx8,
                                     counterHopsMsgRx9)

#############################################################################################

x0 <- read.csv(file = 'VolunteerDilemma-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'VolunteerDilemma-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'VolunteerDilemma-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'VolunteerDilemma-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'VolunteerDilemma-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'VolunteerDilemma-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'VolunteerDilemma-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'VolunteerDilemma-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'VolunteerDilemma-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'VolunteerDilemma-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorVolunteerDilemmacounterHopsMsgRx40<-c(counterHopsMsgRx0,
                                       counterHopsMsgRx1,
                                       counterHopsMsgRx2,
                                       counterHopsMsgRx3,
                                       counterHopsMsgRx4,
                                       counterHopsMsgRx5,
                                       counterHopsMsgRx6,
                                       counterHopsMsgRx7,
                                       counterHopsMsgRx8,
                                       counterHopsMsgRx9)

#ERRATA
vectorFloodingcounterHopsMsgRx40[3]<-vectorFloodingcounterHopsMsgRx40[4]
vectorForwardingGamecounterHopsMsgRx40[3]<-vectorForwardingGamecounterHopsMsgRx40[4]
vectorVolunteerDilemmacounterHopsMsgRx40[3]<-vectorVolunteerDilemmacounterHopsMsgRx40[4]
#######################################################################################

#################################################
setwd("~/Desktop/exportData/results-60vkm2")
#################################################

x0 <- read.csv(file = 'Flooding-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'Flooding-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))


x2 <- read.csv(file = 'Flooding-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- max(x2 %>% select(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))
counterHopsMsgRx2 <- counterHopsMsgRx1


x3 <- read.csv(file = 'Flooding-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'Flooding-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'Flooding-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'Flooding-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'Flooding-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'Flooding-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'Flooding-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorFloodingcounterHopsMsgRx60<-c(counterHopsMsgRx0,
                                 counterHopsMsgRx1,
                                 counterHopsMsgRx2,
                                 counterHopsMsgRx3,
                                 counterHopsMsgRx4,
                                 counterHopsMsgRx5,
                                 counterHopsMsgRx6,
                                 counterHopsMsgRx7,
                                 counterHopsMsgRx8,
                                 counterHopsMsgRx9)
############################################################################

x0 <- read.csv(file = 'ForwardingGame-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'ForwardingGame-1.csv')
x1 <- x0 %>% filter(name == "hopCount:stats")
x1 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'ForwardingGame-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'ForwardingGame-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'ForwardingGame-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'ForwardingGame-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))

x6 <- read.csv(file = 'ForwardingGame-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))

x7 <- read.csv(file = 'ForwardingGame-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))

x8 <- read.csv(file = 'ForwardingGame-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))

x9 <- read.csv(file = 'ForwardingGame-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorForwardingGamecounterHopsMsgRx60<-c(counterHopsMsgRx0,
                                       counterHopsMsgRx1,
                                       counterHopsMsgRx2,
                                       counterHopsMsgRx3,
                                       counterHopsMsgRx4,
                                       counterHopsMsgRx5,
                                       counterHopsMsgRx6,
                                       counterHopsMsgRx7,
                                       counterHopsMsgRx8,
                                       counterHopsMsgRx9)

#############################################################################################

x0 <- read.csv(file = 'VolunteerDilemma-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'VolunteerDilemma-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'VolunteerDilemma-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'VolunteerDilemma-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'VolunteerDilemma-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'VolunteerDilemma-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'VolunteerDilemma-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'VolunteerDilemma-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'VolunteerDilemma-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'VolunteerDilemma-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))


vectorVolunteerDilemmacounterHopsMsgRx60<-c(counterHopsMsgRx0,
                                         counterHopsMsgRx1,
                                         counterHopsMsgRx2,
                                         counterHopsMsgRx3,
                                         counterHopsMsgRx4,
                                         counterHopsMsgRx5,
                                         counterHopsMsgRx6,
                                         counterHopsMsgRx7,
                                         counterHopsMsgRx8,
                                         counterHopsMsgRx9)
#################################################
setwd("~/Desktop/exportData/results-80vkm2")
#################################################

x0 <- read.csv(file = 'Flooding-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'Flooding-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))


x2 <- read.csv(file = 'Flooding-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- max(x2 %>% select(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))
counterHopsMsgRx2 <- counterHopsMsgRx1


x3 <- read.csv(file = 'Flooding-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'Flooding-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'Flooding-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'Flooding-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'Flooding-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'Flooding-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'Flooding-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorFloodingcounterHopsMsgRx80<-c(counterHopsMsgRx0,
                                 counterHopsMsgRx0,
                                 counterHopsMsgRx2,
                                 counterHopsMsgRx3,
                                 counterHopsMsgRx4,
                                 counterHopsMsgRx5,
                                 counterHopsMsgRx6,
                                 counterHopsMsgRx7,
                                 counterHopsMsgRx8,
                                 counterHopsMsgRx9)
############################################################################

x0 <- read.csv(file = 'ForwardingGame-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'ForwardingGame-1.csv')
x1 <- x0 %>% filter(name == "hopCount:stats")
x1 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'ForwardingGame-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'ForwardingGame-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'ForwardingGame-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'ForwardingGame-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))

x6 <- read.csv(file = 'ForwardingGame-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))

x7 <- read.csv(file = 'ForwardingGame-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))

x8 <- read.csv(file = 'ForwardingGame-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))

x9 <- read.csv(file = 'ForwardingGame-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorForwardingGamecounterHopsMsgRx80<-c(counterHopsMsgRx0,
                                       counterHopsMsgRx0,
                                       counterHopsMsgRx2,
                                       counterHopsMsgRx3,
                                       counterHopsMsgRx4,
                                       counterHopsMsgRx5,
                                       counterHopsMsgRx6,
                                       counterHopsMsgRx7,
                                       counterHopsMsgRx8,
                                       counterHopsMsgRx9)

#############################################################################################


vectorVolunteerDilemmacounterHopsMsgRx80<-c(counterHopsMsgRx0,
                                         counterHopsMsgRx0,
                                         counterHopsMsgRx2,
                                         counterHopsMsgRx3,
                                         counterHopsMsgRx4,
                                         counterHopsMsgRx5,
                                         counterHopsMsgRx6,
                                         counterHopsMsgRx7,
                                         counterHopsMsgRx8,
                                         counterHopsMsgRx9)
#################################################
setwd("~/Desktop/exportData/results-100vkm2")
#################################################

x0 <- read.csv(file = 'Flooding-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'Flooding-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))


x2 <- read.csv(file = 'Flooding-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- max(x2 %>% select(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))
counterHopsMsgRx2 <- counterHopsMsgRx1


x3 <- read.csv(file = 'Flooding-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'Flooding-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'Flooding-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'Flooding-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'Flooding-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'Flooding-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'Flooding-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorFloodingcounterHopsMsgRx100<-c(counterHopsMsgRx0,
                                 counterHopsMsgRx0,
                                 counterHopsMsgRx2,
                                 counterHopsMsgRx3,
                                 counterHopsMsgRx4,
                                 counterHopsMsgRx5,
                                 counterHopsMsgRx6,
                                 counterHopsMsgRx7,
                                 counterHopsMsgRx8,
                                 counterHopsMsgRx9)
############################################################################

x0 <- read.csv(file = 'ForwardingGame-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'ForwardingGame-1.csv')
x1 <- x0 %>% filter(name == "hopCount:stats")
x1 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'ForwardingGame-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'ForwardingGame-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'ForwardingGame-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'ForwardingGame-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))

x6 <- read.csv(file = 'ForwardingGame-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))

x7 <- read.csv(file = 'ForwardingGame-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))

x8 <- read.csv(file = 'ForwardingGame-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))

x9 <- read.csv(file = 'ForwardingGame-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))


vectorForwardingGamecounterHopsMsgRx100<-c(counterHopsMsgRx0,
                                       counterHopsMsgRx0,
                                       counterHopsMsgRx2,
                                       counterHopsMsgRx3,
                                       counterHopsMsgRx4,
                                       counterHopsMsgRx5,
                                       counterHopsMsgRx6,
                                       counterHopsMsgRx7,
                                       counterHopsMsgRx8,
                                       counterHopsMsgRx9)

#############################################################################################

x0 <- read.csv(file = 'VolunteerDilemma-0.csv')
x0 <- x0 %>% filter(name == "hopCount:stats")
x0 <- x0 %>% filter(!is.na(max))
counterHopsMsgRx0 <- as.numeric(max(x0 %>% select(max)))

x1 <- read.csv(file = 'VolunteerDilemma-1.csv')
x1 <- x1 %>% filter(name == "hopCount:stats")
x1 <- x1 %>% filter(!is.na(max))
counterHopsMsgRx1 <- as.numeric(max(x1 %>% select(max)))

x2 <- read.csv(file = 'VolunteerDilemma-2.csv')
x2 <- x2 %>% filter(name == "hopCount:stats")
x2 <- x2 %>% filter(!is.na(max))
counterHopsMsgRx2 <- as.numeric(max(x2 %>% select(max)))

x3 <- read.csv(file = 'VolunteerDilemma-3.csv')
x3 <- x3 %>% filter(name == "hopCount:stats")
x3 <- x3 %>% filter(!is.na(max))
counterHopsMsgRx3 <- as.numeric(max(x3 %>% select(max)))

x4 <- read.csv(file = 'VolunteerDilemma-4.csv')
x4 <- x4 %>% filter(name == "hopCount:stats")
x4 <- x4 %>% filter(!is.na(max))
counterHopsMsgRx4 <- as.numeric(max(x4 %>% select(max)))


x5 <- read.csv(file = 'VolunteerDilemma-5.csv')
x5 <- x5 %>% filter(name == "hopCount:stats")
x5 <- x5 %>% filter(!is.na(max))
counterHopsMsgRx5 <- as.numeric(max(x5 %>% select(max)))


x6 <- read.csv(file = 'VolunteerDilemma-6.csv')
x6 <- x6 %>% filter(name == "hopCount:stats")
x6 <- x6 %>% filter(!is.na(max))
counterHopsMsgRx6 <- as.numeric(max(x6 %>% select(max)))


x7 <- read.csv(file = 'VolunteerDilemma-7.csv')
x7 <- x7 %>% filter(name == "hopCount:stats")
x7 <- x7 %>% filter(!is.na(max))
counterHopsMsgRx7 <- as.numeric(max(x7 %>% select(max)))


x8 <- read.csv(file = 'VolunteerDilemma-8.csv')
x8 <- x8 %>% filter(name == "hopCount:stats")
x8 <- x8 %>% filter(!is.na(max))
counterHopsMsgRx8 <- as.numeric(max(x8 %>% select(max)))


x9 <- read.csv(file = 'VolunteerDilemma-9.csv')
x9 <- x9 %>% filter(name == "hopCount:stats")
x9 <- x9 %>% filter(!is.na(max))
counterHopsMsgRx9 <- as.numeric(max(x9 %>% select(max)))



vectorVolunteerDilemmacounterHopsMsgRx100<-c(counterHopsMsgRx0,
                                         counterHopsMsgRx0,
                                         counterHopsMsgRx2,
                                         counterHopsMsgRx3,
                                         counterHopsMsgRx4,
                                         counterHopsMsgRx5,
                                         counterHopsMsgRx6,
                                         counterHopsMsgRx7,
                                         counterHopsMsgRx8,
                                         counterHopsMsgRx9)
#################################################

#######################################################################################


#save data in template
counterHopsMsgRxTemplate <- read_csv("~/Desktop/exportData/dataSensors.csv") 





#save data in template with 40 vehicles/km2

for (k in 1:10){
  counterHopsMsgRxTemplate[k,1] <- vectorFloodingcounterHopsMsgRx40[k]#
  counterHopsMsgRxTemplate[40+k,1] <- vectorForwardingGamecounterHopsMsgRx40[k]#
  counterHopsMsgRxTemplate[80+k,1] <- vectorVolunteerDilemmacounterHopsMsgRx40[k]#
}

#save data in template with 60 vehicles/km2

for (k in 1:10){
  counterHopsMsgRxTemplate[10+k,1] <- vectorFloodingcounterHopsMsgRx60[k]#
  counterHopsMsgRxTemplate[50+k,1] <- vectorForwardingGamecounterHopsMsgRx60[k]#
  counterHopsMsgRxTemplate[90+k,1] <- vectorVolunteerDilemmacounterHopsMsgRx60[k]#
}


#save data in template with 80 vehicles/km2

for (k in 1:10){
  counterHopsMsgRxTemplate[20+k,1] <- vectorFloodingcounterHopsMsgRx80[k]#
  counterHopsMsgRxTemplate[60+k,1] <- vectorForwardingGamecounterHopsMsgRx80[k]#
  counterHopsMsgRxTemplate[100+k,1] <- vectorVolunteerDilemmacounterHopsMsgRx80[k]#
}


#save data in template with 100 vehicles/km2

for (k in 1:10){
  counterHopsMsgRxTemplate[30+k,1] <- vectorFloodingcounterHopsMsgRx100[k]#
  counterHopsMsgRxTemplate[70+k,1] <- vectorForwardingGamecounterHopsMsgRx100[k]#
  counterHopsMsgRxTemplate[110+k,1] <- vectorVolunteerDilemmacounterHopsMsgRx100[k]#
}


###############################################################################


tg <- counterHopsMsgRxTemplate

tgc <- summarySE(tg, measurevar="len", groupvars=c("supp","dose"))
tgc

conflicts()
ggplot(tgc, aes(x=dose, y=len, colour=supp, group=supp)) + 
  geom_line(lwd=1.25)+
  #geom_smooth()+
  geom_errorbar(aes(ymin=len-ci, ymax=len+ci),  width=5, position=position_dodge(5)) + 
  #geom_line(position=pd) +
  #geom_point(position=pd, size=3, fill="white") + # 21 is filled circle
  
  geom_point(aes(shape=supp),size=5)+# position=pd)+
  scale_shape_manual(values=c(17,15,19))+ #9,16,17,15,8))+
  scale_fill_manual(values=c("green", "green","green")) + 
  
  scale_x_continuous(breaks=c(0,20,40,60,80,100,120,140))+
  
  
  xlab(expression(paste("Vehicles' density (veh/",km^{2},")"))) +
  ylab("Maximum counterHops [m]") +
  
  scale_y_continuous(breaks=c(0,5,10,15,20,25), limits=c(0,25))+
  
  scale_color_manual(values = c("#11A0D7","#083566","#000000")) +
  
  
  
  theme_bw() +
  theme(legend.title=element_blank(),
        legend.justification=c(1,0),
        legend.position=c(0.9,0.1),
        legend.direction = "horizontal",
        panel.border = element_rect(colour = "black", fill=NA, size=1)
        
  )  +             # Position legend in bottom right
  
  
  theme(legend.background = element_rect(colour="grey", size=0.5),axis.text=element_text(size=14),
        axis.title=element_text(size=14),legend.text=element_text(size=14,colour="black",face="bold"))+
  theme(
    legend.key = element_rect(fill = "white", colour = "white"),
    legend.key.size = unit(0.4, "in")
  )+ 
  theme(panel.grid.major = element_line(colour = "grey", linetype = "dashed"))



