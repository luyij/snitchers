library("httr")
library("jsonlite")
library("dplyr")
library("pscl")
install.packages("pracma")
library("pracma")

crimeData <- read.csv(file = "Desktop/snitchers/Data/Crime_Data.csv", stringsAsFactors = FALSE)
View(crimeData)

childRelated <- crimeData %>% 
  filter(Primary.Offense.Description == "CHILD-OTHER")
View(childRelated)
## - sector - report time (call report.number report id), (only need morning, afternoon, night), (time become month and year)

crimeData_new <- crimeData %>% 
  select(-Reported.Date, -Sector, - Beat, - Reported.Time) %>% 
    rename(report_id = Report.Number)
View(crimeData_new)

crimeData_new <- crimeData_new %>% 
  mutate(
    Date = paste0(substr(Occurred.Date, 0, 2),substr(Occurred.Date,6,10))
  )
crimeData_new <- crimeData_new %>% 
  select(-Occurred.Date)

crimeData_new <-crimeData_new %>% 
mutate(timing = ifelse(500 <= Occurred.Time & Occurred.Time < 1200 , "morning", ifelse(1200 <= Occurred.Time & Occurred.Time < 1700, 
                                                                                       "afternoon", ifelse(1700 <= Occurred.Time & Occurred.Time < 2400,"night", "latenight"))))
crimeData_new <- crimeData_new %>% 
  select(-Occurred.Time, -Precinct)

crimetype <- crimeData_new %>% 
  mutate(
    happened = 1
  ) %>% 
  group_by(Crime.Subcategory) %>% 
  summarize(
    sum(happened)
  )
x <- substr(crimeData_new$Date,0,2)
View(x)
crimeData_new <- crimeData_new %>% 
  mutate(
    season = ifelse( 1 < as.numeric(substr(Date, 0, 2)) & as.numeric(substr(Date, 0, 2)) <=2 , "winter", ifelse(3 <= as.numeric(substr(Date, 0, 2)) & as.numeric(substr(Date, 0, 2)) <= 5, "spring", ifelse( 6 <=  as.numeric(substr(Date, 0, 2)) & as.numeric(substr(Date, 0, 2)) <= 8 , "summer", ifelse( 9 <=  as.numeric(substr(Date, 0, 2)) & as.numeric(substr(Date, 0, 2)) <= 11,"fall", "winter"))))
    )
    
    is.numeric(x)
is.character(x)
crimeData_new <- crimeData_new %>% select(-season)

View(crimeData_new)
summary(crimeData_new)
##############################


overView <- crimeData_new %>% 
  group_by(Neighborhood, Crime.Subcategory) %>% 
  mutate(
    happened = 1
  ) %>% 
  summarize(    sum(happened)
  )
View(overViewWithWeight)

overViewNew <- overView %>% rename(Crime.Type = Crime.Subcategory)

overViewWithWeight <- left_join(overViewNew, severityWeight, by = "Crime.Type")
overViewWithWeight <- overViewWithWeight %>%  rename(neighborhood = Neighborhood, crimetype = Crime.Type, occurrence = "sum(happened)")


severityWeight<- read.csv(file = "Desktop/snitchers/Data/severityWeight.csv", stringsAsFactors = FALSE)
View(severityWeight)
write.csv(crimeData_new,"Desktop/snitchers/Data/CrimeData_new.csv", row.names = FALSE)
write.csv(overViewWithWeight,"Desktop/snitchers/Data/overViewWithWeight.csv", row.names = FALSE)
  
