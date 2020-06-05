
R=read.csv(file = 'results/M.csv')
tgc <- summarySE(R, measurevar="value", groupvars=c("percent","key"))

ggplot(tgc, aes(x=percent, y=value, colour=key, group=key)) + 
  geom_line(lwd=1.25)+
  geom_errorbar(aes(ymin=value-ci, ymax=value+ci),  width=5, position=position_dodge(5)) + 
  geom_point(aes(shape=key),size=5)+
  xlab("Pecentaje of vehicules with hash") +
  ylab("Number  of message") +
  scale_shape_manual(values=c(17,15,19))+ 
  scale_fill_manual(values=c("green", "green","green")) + 
  scale_x_continuous(breaks=c(0:9)*10)+
  scale_color_manual(values = c("#11A0D7","#083566","#000000"))+
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





R=read.csv(file = 'results/P.csv')
tgc <- summarySE(R, measurevar="value", groupvars=c("percent","key"))


tgc <- summarySE(R, measurevar="value", groupvars=c("percent","key"))

ggplot(tgc, aes(x=percent, y=value, colour=key, group=key)) + 
  geom_line(lwd=1.25)+
  geom_errorbar(aes(ymin=value-ci, ymax=value+ci),  width=5, position=position_dodge(5)) + 
  geom_point(aes(shape=key),size=5)+
  xlab("Pecentaje of vehicules with hash") +
  ylab("Percentage of Message") +
  scale_shape_manual(values=c(17,15))+ 
  scale_fill_manual(values=c("green", "green")) + 
  scale_x_continuous(breaks=c(0:9)*10)+
  scale_y_continuous(breaks=c(0:9)/10)+
  scale_color_manual(values = c("#11A0D7","#083566"))+
  theme_bw() +
  theme(legend.title=element_blank(),
        legend.justification=c(1,0),
        legend.position=c(0.9,0.1),
        legend.direction = "horizontal",
        panel.border = element_rect(colour = "black", fill=NA, size=1)
        
  )  +             # Position legend in bottom right
  
  
  theme(legend.background = element_rect(colour="grey", size=0.5),axis.text=element_text(size=14),
        axis.title=element_text(size=9),legend.text=element_text(size=14,colour="black",face="bold"))+
  theme(
    legend.key = element_rect(fill = "white", colour = "white"),
    legend.key.size = unit(0.4, "in")
  )+ 
  theme(panel.grid.major = element_line(colour = "grey", linetype = "dashed"))


####################POr km2###########################

##############################POrcentaje##################3333

R=read.csv(file = 'results/Mperkm.csv')
tgc <- summarySE(R, measurevar="value", groupvars=c("percent","key"))

ggplot(tgc, aes(x=percent, y=value, colour=key, group=key)) + 
  geom_line(lwd=1.25)+
  geom_errorbar(aes(ymin=value-ci, ymax=value+ci),  width=5, position=position_dodge(5)) + 
  geom_point(aes(shape=key),size=5)+
  xlab(expression(paste("Vehicles' density (veh/",km^{2},")")))+
  ylab("Number  of message") +
  scale_shape_manual(values=c(17,15,19))+ 
  scale_x_continuous(breaks=c(10,25,50,75,100))+
  scale_color_manual(values = c("#11A0D7","#083566","#000000"))+
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





R=read.csv(file = 'results/Pperkm.csv')

tgc <- summarySE(R, measurevar="value", groupvars=c("percent","key"))

ggplot(tgc, aes(x=percent, y=value, colour=key, group=key)) + 
  geom_line(lwd=1.25)+
  geom_errorbar(aes(ymin=value-ci, ymax=value+ci),  width=5, position=position_dodge(5)) + 
  geom_point(aes(shape=key),size=5)+
  
  
  xlab(expression(paste("Vehicles' density (veh/",km^{2},")")))+
  ylab("Percentage of Message") +
  scale_shape_manual(values=c(17,15))+ 
 # scale_fill_manual(values=c("green", "green")) + 
  scale_x_continuous(breaks=c(10,25,50,75,100))+
  scale_y_continuous(breaks=c(0:9)/10)+
  scale_color_manual(values = c("#11A0D7","#083566"))+
  theme_bw() + #cambia a blanco
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










xlab(expression(paste("Vehicles' density (veh/",km^{2},")"))) +
  ylab("Maximum counterHops [m]") +
  
  scale_y_continuous(breaks=c(0,5,10,15,20,25), limits=c(0,25))+
  
  +
  
  
  
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





