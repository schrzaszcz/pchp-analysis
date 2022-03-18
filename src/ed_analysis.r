#Place of Service:
  # 41 - Ambulance (Land)
  # 42 - Ambulance (Air or Water)
  ## for ambulance, look at other payment amounts (not just paid amount)

  ## ED URI Cohort - Place of Service
  table(URI_ED$Place_of_Service)    # no place of service for 41 and 42
    # 23 - Emergency Room
    # 11 - Office
    # 81 - Independent Lab
    # 22 - On Campus/Outpatient Hospital

  ## ED MBH Cohort - Place of Service
  table(MBH_ED$Place_of_Service)    # 41 - 939
  MBH_ED_41=filter(MBH_ED, Place_of_Service==41)
  MBH_ED_41 %>% distinct(MEMBER_ID) %>% tally()     #267  (14% - 1,909 unique members in entire ED MBH Cohort)
  MBH_ED_41cnt <- MBH_ED_41 %>% distinct(MEMBER_ID, DOS, Place_of_Service, DGN1)   #295 unique occurrances/claims for ambulance
  table(MBH_ED_41cnt$DGN1)   #most common diagnosis is F29 - 250
  MBH_ED_41cnt %>% distinct(MEMBER_ID) %>% tally()    #267 unique members use ED
    # 2 times - 20 members
    # 3 times - 1 member
    # 4 times - 2 members  - DGN: F29 - Psychosis not due to substance
  
  sum(MBH_ED_41$PaidAmount)    # $92,490.7
  sum(MBH_ED_41$AllowedAmount)   # $97,385.51
  sum(MBH_ED_41$WithHoldAmount)   # 0.16
  ## compare 41 vs. non 41
  
#Risk Report:
  #History of Hypertension (Chronic Historical Hypertension)
  #Current PIH (Pregnancy Induced Hypertension)

# Summarize all cardiovascular code DGN codes
# PIH Code in Email


#load t_claim and filter out pregnancy
#append gender to pregnancy and filter out only females
  

  
  
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

  
  HTN_codes <- paste(c('H35.031', 'H35.032', 'H35.033', 'H35.039', 'I10', 'I11.0', 'I11.9', 'I12.0', 'I12.9', 'I13.0', 
                       'I13.10', 'I13.11', 'I13.2', 'I15.0', 'I15.1', 'I15.2', 'I15.8', 'I15.9', 'I67.4', 'N26.2'))

  
  PIH_codes <- paste(c( '642.3', '642.30', '642.31', '642.32', '642.33', '642.34', '642.4', '642.40', '642.41', '642.42',
                        '642.43', '642.44', '642.5', '642.50', '642.51', '642.52', '642.53', '642.54', '642.6', '642.60',
                        '642.61', '642.62', '642.63', '642.64', '642.7', '642.70', '642.71', '642.72', '642.73', '642.74',
                        '642.9', '642.90', '642.91', '642.92', '642.93', '642.94', 'O11', 'O11.1', 'O11.2', 'O11.3', 'O11.4',
                        'O11.5', 'O11.9', 'O13', 'O13.1', 'O13.2', 'O13.3', 'O13.4', 'O13.5', 'O13.9', 'O14', 'O14.0', 'O14.00', 
                        'O14.02', 'O14.03', 'O14.04', 'O14.05', 'O14.1', 'O14.10', 'O14.12', 'O14.13', 'O14.14', 'O14.15', 'O14.2', 
                        'O14.20', 'O14.22', 'O14.23', 'O14.24', 'O14.25', 'O14.9', 'O14.90', 'O14.92', 'O14.93', 'O14.94', 'O14.95',
                        'O15', 'O15.0', 'O15.00', 'O15.02', 'O15.03', 'O15.1', 'O15.2', 'O15.9', 'O16', 'O16.1', 'O16.2', 'O16.3',
                        'O16.4', 'O16.5', 'O16.9', '760.0', 'P00.0' ))
  
  
  #look for cardio codes
  preg_16$cardio <- as.numeric(preg_16$DGN1%in%cardio_codes )
  preg_17$cardio <- as.numeric(preg_17$DGN1%in%cardio_codes )
  preg_18$cardio <- as.numeric(preg_18$DGN1%in%cardio_codes )
  preg_19$cardio <- as.numeric(preg_19$DGN1%in%cardio_codes )
  preg_20$cardio <- as.numeric(preg_20$DGN1%in%cardio_codes )
  
  #look for hypertension codes
  preg_16$HTN <- as.numeric(preg_16$DGN1%in%HTN_codes )
  preg_17$HTN <- as.numeric(preg_17$DGN1%in%HTN_codes )
  preg_18$HTN <- as.numeric(preg_18$DGN1%in%HTN_codes )
  preg_19$HTN <- as.numeric(preg_19$DGN1%in%HTN_codes )
  preg_20$HTN <- as.numeric(preg_20$DGN1%in%HTN_codes )
  
  #look for PIH codes
  preg_16$PIH <- as.numeric(preg_16$DGN1%in%PIH_codes | preg_16$DGN2%in%PIH_codes | preg_16$DGN3%in%PIH_codes | preg_16$DGN4%in%PIH_codes | preg_16$DGN5%in%PIH_codes | 
                              preg_16$PROC_1%in%PIH_codes | preg_16$PROC_2%in%PIH_codes | preg_16$PROC_3%in%PIH_codes | preg_16$PROC_4%in%PIH_codes)
  
  preg_17$PIH <- as.numeric(preg_17$DGN1%in%PIH_codes | preg_17$DGN2%in%PIH_codes | preg_17$DGN3%in%PIH_codes | preg_17$DGN4%in%PIH_codes | preg_17$DGN5%in%PIH_codes | 
                              preg_17$PROC_1%in%PIH_codes | preg_17$PROC_2%in%PIH_codes | preg_17$PROC_3%in%PIH_codes | preg_17$PROC_4%in%PIH_codes)
  
  preg_18$PIH <- as.numeric(preg_18$DGN1%in%PIH_codes | preg_18$DGN2%in%PIH_codes | preg_18$DGN3%in%PIH_codes | preg_18$DGN4%in%PIH_codes | preg_18$DGN5%in%PIH_codes | 
                              preg_18$PROC_1%in%PIH_codes | preg_18$PROC_2%in%PIH_codes | preg_18$PROC_3%in%PIH_codes | preg_18$PROC_4%in%PIH_codes)
  
  preg_19$PIH <- as.numeric(preg_19$DGN1%in%PIH_codes | preg_19$DGN2%in%PIH_codes | preg_19$DGN3%in%PIH_codes | preg_19$DGN4%in%PIH_codes | preg_19$DGN5%in%PIH_codes | 
                              preg_19$PROC_1%in%PIH_codes | preg_19$PROC_2%in%PIH_codes | preg_19$PROC_3%in%PIH_codes | preg_19$PROC_4%in%PIH_codes)
  
  preg_20$PIH <- as.numeric(preg_20$DGN1%in%PIH_codes | preg_20$DGN2%in%PIH_codes | preg_20$DGN3%in%PIH_codes | preg_20$DGN4%in%PIH_codes | preg_20$DGN5%in%PIH_codes | 
                              preg_20$PROC_1%in%PIH_codes | preg_20$PROC_2%in%PIH_codes | preg_20$PROC_3%in%PIH_codes | preg_20$PROC_4%in%PIH_codes)

  
  table(preg_16$cardio)  #14
  table(preg_16$HTN)     #14
  table(preg_16$PIH)     #12,582
  table(preg_16$cardio, preg_16$PIH)     #0
  
  
  table(preg_17$cardio)  #67
  table(preg_17$HTN)     #59
  table(preg_17$PIH)     #17,904
  table(preg_17$cardio, preg_17$PIH)     #4
  
  
  table(preg_18$cardio)  #149
  table(preg_18$HTN)     #143
  table(preg_18$PIH)     #37,109
  table(preg_18$cardio, preg_18$PIH)     #44
  
  
  table(preg_19$cardio)  #184
  table(preg_19$HTN)     #146
  table(preg_19$PIH)     #44,300
  table(preg_19$cardio, preg_19$PIH)     #1
  
  
  table(preg_20$cardio)  #181
  table(preg_20$HTN)     #177
  table(preg_20$PIH)     #28,839
  table(preg_20$cardio, preg_20$PIH)     #14
  
  # Time difference between DOS cardio + cardio PIH (Absolute difference - before or after)
  
  # Time difference between DOS cardio + cardio PIH - INPT ONLY (Absolute difference - before or after)
  
  
  
  # filter out by individual years from 2016-2020
  
  pregnant_F$flag16  <- as.numeric( pregnant_F$DOS >= as.Date("2016-01-01") ) & ( pregnant_F$DOS <= as.Date("2016-12-31") )
  pregnant_F$flag17  <- as.numeric( pregnant_F$DOS >= as.Date("2017-01-01") ) & ( pregnant_F$DOS <= as.Date("2017-12-31") )
  pregnant_F$flag18  <- as.numeric( pregnant_F$DOS >= as.Date("2018-01-01") ) & ( pregnant_F$DOS <= as.Date("2018-12-31") )
  pregnant_F$flag19  <- as.numeric( pregnant_F$DOS >= as.Date("2019-01-01") ) & ( pregnant_F$DOS <= as.Date("2019-12-31") )
  pregnant_F$flag20  <- as.numeric( pregnant_F$DOS >= as.Date("2020-01-01") ) & ( pregnant_F$DOS <= as.Date("2020-12-31") )
  
  preg_16=filter(pregnant_F, flag16=="TRUE")
  preg_17=filter(pregnant_F, flag17=="TRUE")
  preg_18=filter(pregnant_F, flag18=="TRUE")
  preg_19=filter(pregnant_F, flag19=="TRUE")
  preg_20=filter(pregnant_F, flag20=="TRUE")
  
  
