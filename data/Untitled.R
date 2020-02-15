library("httr")
library("jsonlite")
library("dplyr")
library("pscl")

crimeData <- read.csv(file = "Desktop/snitchers/Isan/Crime_Data.csv", stringsAsFactors = FALSE)
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
mutate(timing = ifelse(500 <= Occurred.Time & Occurred.Time < 1200 , "morning", ifelse(1200 < Occurred.Time & Occurred.Time < 1700, 
                                                                                       "afternoon", "night")))
crimeData_new <- crimeData_new %>% 
  select(-Occurred.Time, - Crime.Subcategory, -Precinct)

crimetype <- crimeData_new %>% 
  mutate(
    happened = 1
  ) %>% 
  group_by(Primary.Offense.Description) %>% 
  summarize(
    sum(happened)
  )

View(crimetype)
summary(crimeData_new)
write.csv(crimeData_new,"Desktop/snitchers/Isan/CrimeData_new.csv", row.names = FALSE)
  
