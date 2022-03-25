# Download Zip and unzip (CDI_Longitudinal_Data_original)

Transportation = read.csv ("//sc-acs228-1.parknet-ad.pmh.org/users$/P108275/Documents/CDI_Longitudinal_Data_original/CDI_Longitudinal_Data_original/indicator_transportation_cost.csv")

Poverty = read.csv ("//sc-acs228-1.parknet-ad.pmh.org/users$/P108275/Documents/CDI_Longitudinal_Data_original/CDI_Longitudinal_Data_original/indicator_poverty.csv")

Income = read.csv ("//sc-acs228-1.parknet-ad.pmh.org/users$/P108275/Documents/CDI_Longitudinal_Data_original/CDI_Longitudinal_Data_original/indicator_medianincome.csv")

ADI = read.csv ("//sc-acs228-1.parknet-ad.pmh.org/users$/P108275/Documents/CDI_Longitudinal_Data_original/CDI_Longitudinal_Data_original/indicator_adi.csv")

#load URI_ED dataset
load("~/URI_ED.RData")    #478,568
URI_mem <- URI_ED[-c(1:31,33:40)]
URI_mem <- URI_mem %>% distinct()   


#load Jan 2021 mem dataset
ZipCode <- pchp_mem[-c(2:10,12:20)]

URI_mem <- merge(x=URI_mem, y=ZipCode, by.x = "MEMBER_ID", by.y = "MemberID", all.x=TRUE)  


#ADI
  ADI <- ADI[-c(1:2,4:5,7:8,11:12)]
  ADI <- ADI %>% distinct()
  ADI <- rename(ADI, ADI_value = indicator_value)
  ADI <- rename(ADI, ADI_direction = direction)
  ADI <- rename(ADI, ADI_value_units = indicator_value_units)

  ADI <- merge(x=URI_mem, y=ADI, by.x = "ZipCode", by.y = "zipcode", all.x=TRUE)  

  sum(is.na(ADI$ADI_value))   
  
#Income
  Income <- Income[-c(1:2,4:5,7:9,12:13)]
  Income <- Income %>% distinct()
  Income <- rename(Income, Median_Income_value = indicator_value)
  Income <- rename(Income, Median_Income_direction = direction)
  Income <- rename(Income, Median_Income_value_units = indicator_value_units)
  
  Income <- merge(x=URI_mem, y=Income, by.x = "ZipCode", by.y = "zipcode", all.x=TRUE)   

  sum(is.na(Income$Median_Income_value))  
  
  
#Poverty
  Poverty <- Poverty[-c(1:2,4:5,7:9,12:13)]
  Poverty <- Poverty %>% distinct()
  Poverty <- rename(Poverty, Poverty_value = indicator_value)
  Poverty <- rename(Poverty, Poverty_direction = direction)
  Poverty <- rename(Poverty, Poverty_value_units = indicator_value_units)
  
  Poverty <- merge(x=URI_mem, y=Poverty, by.x = "ZipCode", by.y = "zipcode", all.x=TRUE)   

  sum(is.na(Poverty$Poverty_value))   
  
  
#Transportation
  Transportation <- Transportation[-c(1:2,4:5,7:9,12:13)]
  Transportation <- Transportation %>% distinct()
  Transportation <- rename(Transportation, Transportation_value = indicator_value)
  Transportation <- rename(Transportation, Transportation_direction = direction)
  Transportation <- rename(Transportation, Transportation_value_units = indicator_value_units)
  
  Transportation <- merge(x=URI_mem, y=Transportation, by.x = "ZipCode", by.y = "zipcode", all.x=TRUE)  
  
  
# Observation: Different indicator values for same zip codes
# Take the average value by Zip Code?
  
# Indicators with all values:
 
# ADI - the lower, the better   
  range(ADI$ADI_value, na.rm=T)  
  median(ADI$ADI_value, na.rm=T) 
  mean(ADI$ADI_value, na.rm=T) 
  
# Income - the higher, the better   
  range(Income$Median_Income_value, na.rm=T)  
  median(Income$Median_Income_value, na.rm=T) 
  mean(Income$Median_Income_value, na.rm=T)  
  
# Poverty - the higher, the better   
  range(Poverty$Poverty_value, na.rm=T) 
  median(Poverty$Poverty_value, na.rm=T)
  mean(Poverty$Poverty_value, na.rm=T)  
  
# Transportation - the lower, the better   
  range(Transportation$Transportation_value, na.rm=T)  
  median(Transportation$Transportation_value, na.rm=T) 
  mean(Transportation$Transportation_value, na.rm=T)  

  
