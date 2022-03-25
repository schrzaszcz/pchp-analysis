library(dplyr)
library(mondate)
library(lubridate)


## load January 2021 claims data set
load("//sc-acs228-1.parknet-ad.pmh.org/PCCIFS/PCHPAsthma/Data/PCHP raw data/Raw_Data_January_2021/PCHP_claims_new_January.RData")
claims <- pchp_claims   

  #change DOS for all claims to be between 2016-2020
  range(claims$DOS) 

  claims$flag  <- as.numeric( claims$DOS >= as.Date("2016-01-01") ) & ( claims$DOS <= as.Date("2020-12-31") )    # flag DOS so it is for 5 years from Jan. 1, 2016 to Dec. 31, 2020
  claims=filter(claims,flag=="TRUE")   
  range(claims$DOS)  
  claims <- claims[-c(41)]

#load("//sc-acs228-1.parknet-ad.pmh.org/PCCIFS/PCHPAsthma/Sandra Internship/PCHP Claims/claims.RData")


cardio_codes <- paste(c('I21.01', 'I21.02', 'I21.09', 'I21.11', 'I21.19', 'I21.21', 'I21.29', 'I21.3',
                        'I21.4', 'I21.9', 'I21.A1', 'I21.A9', 'I22.0', 'I22.1', 'I22.2', 'I22.8', 'I22.9',
                        'I09.81', 'I11.0', 'I13.0', 'I13.2', 'I50.1', 'I50.20', 'I50.21', 'I50.22', 'I50.23',
                        'I50.30', 'I50.31', 'I50.32', 'I50.33', 'I50.40', 'I50.41', 'I50.42', 'I50.43',
                        'I50.810', 'I50.811', 'I50.812', 'I50.813', 'I50.814', 'I50.82', 'I50.83', 'I50.84', 
                        'I50.89', 'I50.9', 'I48.0', 'I48.1', 'I48.2', 'I48.91', 'I20.0', 'I20.1', 'I20.8', 
                        'I20.9', 'I21.01', 'I21.02', 'I21.09', 'I21.11', 'I21.19', 'I21.21', 'I21.29', 
                        'I21.3', 'I21.4', 'I21.A1', 'I21.A9', 'I22.0', 'I22.1', 'I22.2', 'I22.8', 'I22.9', 
                        'I23.0', 'I23.1', 'I23.2', 'I23.3', 'I23.4', 'I23.5', 'I23.6', 'I23.7', 'I23.8', 
                        'I24.0', 'I24.1', 'I24.8', 'I24.9', 'I25.10', 'I25.110', 'I25.111', 'I25.118', 
                        'I25.119', 'I25.2', 'I25.3', 'I25.41', 'I25.42', 'I25.5', 'I25.6', 'I25.700',
                        'I25.701', 'I25.708', 'I25.709', 'I25.710', 'I25.711', 'I25.718', 'I25.719', 
                        'I25.720', 'I25.721', 'I25.728', 'I25.729', 'I25.730', 'I25.731', 'I25.738', 
                        'I25.739', 'I25.750', 'I25.751', 'I25.758', 'I25.759', 'I25.760', 'I25.761', 
                        'I25.768', 'I25.769', 'I25.790', 'I25.791', 'I25.798', 'I25.799', 'I25.810', 
                        'I25.811', 'I25.812', 'I25.82', 'I25.83', 'I25.84', 'I25.89', 'I25.9', 'H35.031', 
                        'H35.032', 'H35.033', 'H35.039', 'I10', 'I11.0', 'I11.9', 'I12.0', 'I12.9', 'I13.0', 
                        'I13.10', 'I13.11', 'I13.2', 'I15.0', 'I15.1', 'I15.2', 'I15.8', 'I15.9', 'I67.4', 'N26.2'))


HTN_codes <- paste(c('H35.031', 'H35.032', 'H35.033', 'H35.039', 'I10', 'I11', 'I11.0', 'I11.9', 'I12', 'I12.0', 'I12.9', 'I13', 'I13.0', 'I13.1',
                     'I13.10', 'I13.11', 'I13.2', 'I15', 'I15.0', 'I15.1', 'I15.2', 'I15.8', 'I15.9', 'I16', 'I16.1', 'I16.9', 'I67.4', 'N26.2'))


PIH_codes <- paste(c( '642.3', '642.30', '642.31', '642.32', '642.33', '642.34', '642.4', '642.40', '642.41', '642.42',
                      '642.43', '642.44', '642.5', '642.50', '642.51', '642.52', '642.53', '642.54', '642.6', '642.60',
                      '642.61', '642.62', '642.63', '642.64', '642.7', '642.70', '642.71', '642.72', '642.73', '642.74',
                      '642.9', '642.90', '642.91', '642.92', '642.93', '642.94', 'O11', 'O11.1', 'O11.2', 'O11.3', 'O11.4',
                      'O11.5', 'O11.9', 'O13', 'O13.1', 'O13.2', 'O13.3', 'O13.4', 'O13.5', 'O13.9', 'O14', 'O14.0', 'O14.00', 
                      'O14.02', 'O14.03', 'O14.04', 'O14.05', 'O14.1', 'O14.10', 'O14.12', 'O14.13', 'O14.14', 'O14.15', 'O14.2', 
                      'O14.20', 'O14.22', 'O14.23', 'O14.24', 'O14.25', 'O14.9', 'O14.90', 'O14.92', 'O14.93', 'O14.94', 'O14.95',
                      'O15', 'O15.0', 'O15.00', 'O15.02', 'O15.03', 'O15.1', 'O15.2', 'O15.9', 'O16', 'O16.1', 'O16.2', 'O16.3',
                      'O16.4', 'O16.5', 'O16.9', '760.0', 'P00.0' ))


# define claims that have a cardiovascular related visit

  claims$cardio <- as.numeric(claims$DGN1%in%cardio_codes )
  table(claims$cardio)   
  cardio=filter(claims, cardio==1)  


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


  #look for pregnancy codes among all claims
  claims$pregnant <- as.numeric(claims$DGN1%in%prenatal_B | claims$DGN2%in%prenatal_B | claims$DGN3%in%prenatal_B | claims$DGN4%in%prenatal_B | claims$DGN5%in%prenatal_B |
                                  claims$PROC_1%in%prenatal_B | claims$PROC_2%in%prenatal_B | claims$PROC_3%in%prenatal_B | claims$PROC_4%in%prenatal_B)

  table(claims$pregnant)  # 2,479,357 pregnant - gender not assigned yet 

  # look for pregnancy codes among cardiovascular diseases 
  cardio$pregnant <- as.numeric(cardio$DGN1%in%prenatal_B | cardio$DGN2%in%prenatal_B | cardio$DGN3%in%prenatal_B | cardio$DGN4%in%prenatal_B | cardio$DGN5%in%prenatal_B |
                                  cardio$PROC_1%in%prenatal_B | cardio$PROC_2%in%prenatal_B | cardio$PROC_3%in%prenatal_B | cardio$PROC_4%in%prenatal_B)
  
  table(cardio$pregnant)  # 597 pregnant AND cardio primary DGN - gender not assigned yet 
  
  
  ##cardio_all_claims <- claims %>% filter(MEMBER_ID %in% cardio$MEMBER_ID)
 


       
  # filter out pregnancy from all claims
  preg_all=filter(claims, pregnant==1)  
  
  
# assign gender 

  ## load January 2021 mem data set
  load("//sc-acs228-1.parknet-ad.pmh.org/PCCIFS/PCHPAsthma/Data/PCHP raw data/Raw_Data_January_2021/PCHP_mem_new_January.RData")

  gender <- pchp_mem[-c(2:13,15:20)]   
  
  cardio <- merge(x=cardio, y=gender, by.x = "MEMBER_ID", by.y = "MemberID", all.x=TRUE)   
  preg_all <- merge(x=preg_all, y=gender, by.x = "MEMBER_ID", by.y = "MemberID", all.x=TRUE)   
  
  table(cardio$pregnant, cardio$Gender)  
  table(preg_all$Gender)  
  
  
  #filter only pregnant females
  table(preg_all$Gender)   
  preg_all=filter(preg_all, Gender=="F")
  
  table(preg_all$Gender, preg_all$cardio) 
  
  
#look for hypertension codes
  cardio$HTN <- as.numeric(cardio$DGN1%in%HTN_codes )
  table(cardio$HTN)  

#look for PIH codes
  cardio$PIH <- as.numeric(cardio$DGN1%in%PIH_codes | cardio$DGN2%in%PIH_codes | cardio$DGN3%in%PIH_codes | cardio$DGN4%in%PIH_codes | cardio$DGN5%in%PIH_codes | 
                             cardio$PROC_1%in%PIH_codes | cardio$PROC_2%in%PIH_codes | cardio$PROC_3%in%PIH_codes | cardio$PROC_4%in%PIH_codes)
  
  table(cardio$PIH)    
  
  table(cardio$HTN, cardio$PIH)     
  
  table(cardio$pregnant, cardio$PIH)    
  
  
# assign month of prenatal visit 
  
  preg_cardio=filter(cardio, pregnant==1)   
  preg_cardio=filter(preg_cardio, Gender=="F")   
  
  
  result_all <- preg_all %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2016, 2017, 2018, 2019, 2020)) %>% 
    distinct(MEMBER_ID, substr(DOS, 1, 7))  # 176,650
  names(result_all) <- c("MEMBER_ID", "month_of_prenatal_visits")
  result_all %>% distinct(MEMBER_ID) %>% tally()  # 35,507  unique women pregnant during 2016-2020
  
  result_cardio <- preg_cardio %>% filter(DOS-DOB >= 365.25*11 & DOS-DOB <= 365.25*55 & year(DOS) %in% c(2016, 2017, 2018, 2019, 2020)) %>% 
    distinct(MEMBER_ID, substr(DOS, 1, 7))  # 169
  names(result_cardio) <- c("MEMBER_ID", "month_of_prenatal_visits")
  result_cardio %>% distinct(MEMBER_ID) %>% tally()  # 128  unique women pregnant during 2016-2020 with cardio DGN
  
# assign new pregnancy flag  
  
  cardio$preg_hist <- ifelse(cardio$MEMBER_ID %in% result_all$MEMBER_ID, 1, 0)
  cardio$preg_cardio <- ifelse(cardio$MEMBER_ID %in% result_cardio$MEMBER_ID, 1, 0)
  
  table(cardio$pregnant, cardio$Gender)   #595  (from original pregnancy flag)
  table(cardio$preg_cardio)   #1,550  (cardio only pregnant - from result_cardio filter)
  table(cardio$preg_hist)   #9,345   (all historical pregnant - from result_all filter)
  
  
  
#filter by visit type
  cardio_ED=filter(cardio, ED==1)    
  cardio_inpt=filter(cardio, inpt==1)  
  cardio_outpt=filter(cardio, outpt==1)    
  
# pregnant count by visit type
  table(cardio_inpt$pregnant)     
  table(cardio_inpt$preg_cardio)   
  table(cardio_inpt$preg_hist)    
  
  table(cardio_ED$pregnant)     
  table(cardio_ED$preg_cardio) 
  table(cardio_ED$preg_hist)    
  
  table(cardio_outpt$pregnant)     
  table(cardio_outpt$preg_cardio)  
  table(cardio_outpt$preg_hist)    
  
#unique member count for each pregnant flag  
   
  cardio_inpt %>% group_by(pregnant) %>% distinct(MEMBER_ID) %>% tally()     
  cardio_inpt %>% group_by(preg_cardio) %>% distinct(MEMBER_ID) %>% tally()  
  cardio_inpt %>% group_by(preg_hist) %>% distinct(MEMBER_ID) %>% tally()    
  
  cardio_ED %>% group_by(pregnant) %>% distinct(MEMBER_ID) %>% tally()     
  cardio_ED %>% group_by(preg_cardio) %>% distinct(MEMBER_ID) %>% tally()  
  cardio_ED %>% group_by(preg_hist) %>% distinct(MEMBER_ID) %>% tally()    
  
  cardio_outpt %>% group_by(pregnant) %>% distinct(MEMBER_ID) %>% tally()    
  cardio_outpt %>% group_by(preg_cardio) %>% distinct(MEMBER_ID) %>% tally()  
  cardio_outpt %>% group_by(preg_hist) %>% distinct(MEMBER_ID) %>% tally()    
  
#unique member count for PIH
  
  cardio_inpt %>% group_by(PIH) %>% distinct(MEMBER_ID) %>% tally()    
  cardio_ED %>% group_by(PIH) %>% distinct(MEMBER_ID) %>% tally()    
  cardio_outpt %>% group_by(PIH) %>% distinct(MEMBER_ID) %>% tally()    
  
  
  
 
