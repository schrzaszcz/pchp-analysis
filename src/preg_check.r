cardio=filter(topconditions, `Cardiovascular Diseases` =="TRUE")   
cardio_inpt=filter(cardio, inpt==1)  

## load pchp_mem data from January 2021
gender <- pchp_mem[-c(2:13,15:20)]
View(gender)
# merge gender
cardio_inpt <- merge(x=cardio_inpt, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)

# pregnancy is defined from two sources -
# 1) HEDIS criteria
# 2) risk group ID - we don't have risk group data back in 2016 and 2017, starting receiving it from March 2018

prenatal_BICD1 <- paste(c('Z36.2','640.00','640.80','640.90','O33.7','O34.21','O34.51','O34.52','O34.53','O34.59'
                          ,'640.03','O20.0','640.83','O20.8','640.93','O20.9','641.03','O44.01','O44.02','O44.03','O44.21','O44.22','O44.23'
                          ,'O44.41','O44.42','O44.43','641.13','O44.11','O44.12','O44.13','O44.31','O44.32','O44.33','O44.51','O44.52','O44.53'
                          ,'641.23','O45.8X1','O45.8X2','O45.8X3','O45.91','O45.92','O45.93'
                          ,'641.33','O45.001','O45.002','O45.003','O45.011','O45.012','O45.013','O45.021','O45.022','O45.023','O45.091','O45.092','O45.093','O46.001','O46.002','O46.003'
                          ,'O46.011','O46.012','O46.013','O46.021','O46.022','O46.023','O46.091','O46.092','O46.093'
                          ,'641.83','O46.8X1','O46.8X2','O46.8X3','641.93','O46.91','O46.92','O46.93','642.03','O10.011','O10.012','O10.013','O10.911','O10.912'
                          ,'O10.913','642.13','O10.411','O10.412','O10.413','642.23','O10.111','O10.112','O10.113','O10.211','O10.212','O10.213','O10.311','O10.312'
                          ,'O10.313','O11.1','O11.2','O11.3','642.33','O13.1','O13.2','O13.3','O16.1','O16.2','O16.3'
                          ,'642.43','O14.02','O14.03','O14.92','O14.93','642.53','O14.12','O14.13','O14.22','O14.23','642.63','O15.02','O15.03'
                          ,'642.73','O11.1','O11.2','O11.3','642.93','O16.1','O16.2','O16.3','643.03','O21.0','643.13','O21.1','643.23','O21.2'
                          ,'643.83','O21.8','643.93','O21.9','644.03','O60.02','O60.03','644.13','O47.02','O47.03','O47.1','645.13','O48.0','645.23','O48.1'
                          ,'646.03','O31.01X0','O31.02X0','O31.03X0','646.13','O12.01','O12.02','O12.03','O12.21','O12.22','O12.23','O26.01','O26.02','O26.03'
                          ,'646.23','O26.831','O26.832','O26.833','646.33','O26.21','O26.22','O26.23','646.43','O26.821','O26.822','O26.823','646.53','O23.41'
                          ,'O23.42','O23.43','646.63','O23.91','O23.92','O23.93','646.73','O26.611','O26.612','O26.613'
                          ,'646.83','O26.11','O26.12','O26.13','O26.41','O26.42','O26.43','O26.811','O26.812','O26.813','O26.891','O26.892','O26.893','O99.89'
                          ,'646.93','O99.89','647.03','O98.111','O98.112','O98.113','647.13','O98.211','O98.212','O98.213'
                          ,'647.23','O98.311','O98.312','O98.313','647.33','O98.011','O98.012','O98.013','647.43','O98.611','O98.612','O98.613'
                          ,'647.53','O98.511','O98.512','O98.513','647.63','647.83','O98.611','O98.612','O98.613','O98.811','O98.812','O98.813'
                          ,'647.93','O98.911','O98.912','O98.913','648.03','O24.911','O24.912','O24.913','648.13','O99.281','O99.282','O99.283'
                          ,'648.23','O99.011','O99.012','O99.013','648.33','O99.321','O99.322','O99.323','648.43','O99.341','O99.342','O99.343'
                          ,'648.53','O99.411','O99.412','O99.413','648.63','O99.411','O99.412','O99.413','648.73','O33.0','648.83','O24.415','O24.419','O99.810'
                          ,'648.93','O25.11','O25.12','O25.13','O99.281','O99.282','O99.283','649.03','O99.331','O99.332','O99.333'
                          ,'649.13','O99.211','O99.212','O99.213','649.23','O99.841','O99.842','O99.843','649.33','O99.111','O99.112','O99.113'
                          ,'649.43','O99.351','O99.352','O99.353','649.53','O26.851','O26.852','O26.853','649.63','O26.841','O26.842','O26.843'
                          ,'649.73','O26.872','O26.872','651.03','O30.001','O30.002','O30.003','651.13','O30.101','O30.102','O30.103'
                          ,'651.23','O30.201','O30.202','O30.203','651.33','O31.11X0','651.43','651.53','651.63','651.73','O31.31X0','O31.32X0','O31.32X0' 
                          ,'651.83','O30.801','O30.802','O30.803','O31.8X10','O31.8X20','O31.8X30','651.93','O30.91','O30.92','O30.93'
                          ,'652.03','O32.0XX0','652.13','O32.1XX0','652.23','O32.1XX0','652.33','O32.2XX0'
                          ,'652.43','O32.3XX0','652.53','O32.4XX0','652.63','O32.9XX0','652.73','O32.8XX0','652.83','O32.6XX0','O32.8XX0'
                          ,'652.93','O32.9XX0','653.03','O33.0','653.13','O33.1','653.23','O33.2','653.33','O33.3XX0','653.43','O33.4XX0','653.53','O33.5XX0'
                          ,'653.63','O33.6XX0','653.73','O33.7XX0','O33.7XX1','O33.7XX1','O33.7XX2','O33.7XX4','O33.7XX5','O33.7XX9'
                          ,'653.83','O33.8','653.93','O33.9','654.03','O34.01','O34.02','O34.03','654.13','O34.11','O34.12','O34.13'
                          ,'654.23','O34.211','O34.212','O34.219','654.33','O34.511','O34.512','O34.513','O34.531','O34.532','O34.533'
                          ,'654.43','O34.521','O34.522','O34.523','O34.591','O34.592','O34.593','654.53','O34.31','O34.32','O34.33' 
                          ,'654.63','O34.41','O34.42','O34.43','654.73','O34.61','O34.62','O34.63','654.83','O34.71','O34.72','O34.73'
                          ,'654.93','O34.29','O34.81','O34.82','O34.83','O34.91','O34.92','O34.93','655.03','O35.0XX0','655.13','O35.1XX0'
                          ,'655.23','O35.2XX0','655.33','O35.3XX0','655.43','O35.4XX0','655.53','O35.5XX0'
                          ,'655.63','O35.6XX0','655.73','O36.8120','O36.8130','O36.8190','655.83','O35.8XX0','655.93','O35.9XX0','656.03','O43.011'
                          ,'656.13','O36.0110','O36.0120','O36.0130','O36.0910','O36.0920','O36.0930'
                          ,'656.23','O36.1110','O36.1120','O36.1130','O36.1910','O36.1920','O36.1930','656.33','O68','656.43','O36.4XX0'
                          ,'656.53','O36.5110','O36.5120','O36.5130','O36.5910','O36.5920','O36.5930','656.63','O36.61X0','O36.62X0','O36.63X0'
                          ,'656.73','O43.101','O43.102','O43.103','O43.811','O43.812','O43.813','O43.91','O43.92','O43.93'
                          ,'656.83','O36.8310','O36.8320','O36.8330','O36.8910','O36.8920','O36.8930','O68','656.93','O36.91X0','O36.92X0','O36.93X0'
                          ,'657.03','O40.1XX0','O40.2XX0','O40.3XX0','658.03','O41.01X0','O41.02X0','O41.03X0','658.13','O42.011','O42.012','O42.013'
                          ,'658.23','O42.111','O42.112','O42.113','658.33','O75.5'
                          ,'658.43','O41.1010','O41.1020','O41.1030','O41.1210','O41.1220','O41.1230','O41.1410','O41.1420','O41.1430'
                          ,'658.83','O41.8X10','O41.8X20','O41.8X30','658.93','O41.91X0','O41.92X0','O41.93X0','659.03','O61.1','659.13','O61.0'
                          ,'659.23','O75.2','659.33','O75.3','659.43','O09.41','O09.42','O09.43','659.53','O09.511','O09.512','O09.513'
                          ,'659.63','O09.521','O09.522','O09.523','659.73','O76','659.83','O75.89','659.93','O75.9','678.03','O35.8XX0','O36.8210','O36.8220','O36.8230'
                          ,'678.13','O30.021','O30.022','O30.023','679.03','O26.891','O26.892','O26.893','679.13','O35.7XX0'
                          ,'V22.0','Z34.00','V22.1','Z34.80','Z34.90'
                          ,'V22.2','Z33.1','Z33.3','V28.0','Z36.0','V28.1','Z36.1','V28.2','Z36.89','V28.3','Z36.3','V28.4','Z36.4','V28.5','Z36.5'
                          ,'V28.6','Z36.85','V28.81','Z36.89','V28.82','Z36.89','V28.89','Z36.81','Z36.82','Z36.83','Z36.84','Z36.86','Z36.87','Z36.88','Z36.89','Z36.8A'
                          ,'V28.9','Z36.9','V23.0','O09.00','V23.1','O09.10','O09.A0','V23.2','O09.291','V23.3'
                          ,'O09.40','V23.41','O09.211','V23.42','O09.10','V23.49','O09.291','V23.5','O09.291','V23.7','O09.30','V23.81','O09.511','V23.82','O09.521'
                          ,'V23.83','O09.611','V23.84','O09.621','V23.85','O09.819','V23.86','O09.821','O09.822','O09.823','O09.829','V23.87','O36.80X0'
                          ,'V23.89','O09.891','O09.892','O09.893','O09.899','V23.9','O09.90','O09.91','O09.92','O09.93'
                          ,'88.78','BY49ZZZ','BY4CZZZ','BY4FZZZ'))

prenatal_B1 <- c(unique(prenatal_BICD1)) 

# 18 codes
prenatal_B2 <- paste(c('76801','76805','76811','76813','76815','76816','76817','76818','80055','0500F','0501F','0502F','H1000','H1001','H1002','H1003','H1004','H1005'))

prenatal_B <- c(prenatal_B1, prenatal_B2) 


#look for pregnancy codes
cardio_inpt$pregnant2 <- as.numeric(cardio_inpt$DGN1%in%prenatal_B | cardio_inpt$DGN2%in%prenatal_B | cardio_inpt$DGN3%in%prenatal_B | cardio_inpt$DGN4%in%prenatal_B |
                                     cardio_inpt$DGN5%in%prenatal_B | cardio_inpt$PROC_1%in%prenatal_B | cardio_inpt$PROC_2%in%prenatal_B | cardio_inpt$PROC_3%in%prenatal_B | cardio_inpt$PROC_4%in%prenatal_B)

table(cardio_inpt$pregnant2, cardio_inpt$Gender)  


#attach gender to inpatient cardio patients

inpt_members_16 <- merge(x=inpt_members_16, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)
inpt_members_17 <- merge(x=inpt_members_17, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)
inpt_members_18 <- merge(x=inpt_members_18, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)
inpt_members_19 <- merge(x=inpt_members_19, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)
inpt_members_20 <- merge(x=inpt_members_20, y=gender, by.x ="MEMBER_ID", by.y="MemberID", all.x=TRUE)

table(inpt_members_16$Gender)   
table(inpt_members_17$Gender)   
table(inpt_members_18$Gender)  
table(inpt_members_19$Gender)   
table(inpt_members_20$Gender)    

F_inpt_16 = filter(inpt_members_16, Gender=="F")   
F_inpt_17 = filter(inpt_members_17, Gender=="F")   
F_inpt_18 = filter(inpt_members_18, Gender=="F")   
F_inpt_19 = filter(inpt_members_19, Gender=="F")   
F_inpt_20 = filter(inpt_members_20, Gender=="F")   


# load t_claim and filter pregnancy
t_claim=filter(t_claim, pregnant==1)    


result_2016 <- t_claim %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2016)) %>% 
  distinct(MEMBER_ID, substr(DOS, 1, 7))  
names(result_2016) <- c("MEMBER_ID", "month_of_prenatal_visits")
result_2016 %>% distinct(MEMBER_ID) %>% tally()  


result_2017 <- t_claim %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2017)) %>% 
  distinct(MEMBER_ID, substr(DOS, 1, 7))  
names(result_2017) <- c("MEMBER_ID", "month_of_prenatal_visits")
result_2017 %>% distinct(MEMBER_ID) %>% tally()  


result_2018 <- t_claim %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2018)) %>% 
  distinct(MEMBER_ID, substr(DOS, 1, 7))  
names(result_2018) <- c("MEMBER_ID", "month_of_prenatal_visits")
result_2018 %>% distinct(MEMBER_ID) %>% tally()  


result_2019 <- t_claim %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2019)) %>% 
  distinct(MEMBER_ID, substr(DOS, 1, 7))  
names(result_2019) <- c("MEMBER_ID", "month_of_prenatal_visits")
result_2019 %>% distinct(MEMBER_ID) %>% tally() 


result_2020 <- t_claim %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2020)) %>% 
  distinct(MEMBER_ID, substr(DOS, 1, 7))  
names(result_2020) <- c("MEMBER_ID", "month_of_prenatal_visits")
result_2020 %>% distinct(MEMBER_ID) %>% tally()  


#attach pregnancy status to female inpatient cardio patients

F_inpt_16$preg <- ifelse(F_inpt_16$MEMBER_ID %in% result_2016$MEMBER_ID, 1, 0)
F_inpt_17$preg <- ifelse(F_inpt_17$MEMBER_ID %in% result_2017$MEMBER_ID, 1, 0)
F_inpt_18$preg <- ifelse(F_inpt_18$MEMBER_ID %in% result_2018$MEMBER_ID, 1, 0)
F_inpt_19$preg <- ifelse(F_inpt_19$MEMBER_ID %in% result_2019$MEMBER_ID, 1, 0)
F_inpt_20$preg <- ifelse(F_inpt_20$MEMBER_ID %in% result_2020$MEMBER_ID, 1, 0)


table(F_inpt_16$preg) 
table(F_inpt_17$preg)  
table(F_inpt_18$preg)  
table(F_inpt_19$preg)  
table(F_inpt_20$preg)  


F_inpt_16 <- merge(x=F_inpt_16, y=result_2016, by.x ="MEMBER_ID", by.y="MEMBER_ID", all.x=TRUE)
F_inpt_17 <- merge(x=F_inpt_17, y=result_2017, by.x ="MEMBER_ID", by.y="MEMBER_ID", all.x=TRUE)
F_inpt_18 <- merge(x=F_inpt_18, y=result_2018, by.x ="MEMBER_ID", by.y="MEMBER_ID", all.x=TRUE)
F_inpt_19 <- merge(x=F_inpt_19, y=result_2019, by.x ="MEMBER_ID", by.y="MEMBER_ID", all.x=TRUE)
F_inpt_20 <- merge(x=F_inpt_20, y=result_2020, by.x ="MEMBER_ID", by.y="MEMBER_ID", all.x=TRUE)





