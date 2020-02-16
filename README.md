# Seattle Crime Dataset

**2020 Dubstech Datathon -- Team Snitchers**

**Dataset:** https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy

**Task Category:** Data Visualization, Data Analysis, and Machine Learning Modelling

This data represents crime reported to the Seattle Police Department (SPD). Each row contains the record of a unique event where at least one criminal offense was reported by a member of the community or detected by an officer in the field. These data contain offenses and offense categorization coded to simulate the standard reported to the FBI under the National Incident-Based Reporting System (NIBRS) and used to generate a Uniform Crime Report (UCR) summary statistics.

This dataset includes all records of crime reports logged in the Departments Records Management System (RMS) since 2008, which are tracked as part of the SeaStat process. In an effort to safeguard the privacy of our community, offense reports can only be located to the “beat” level and neighborhood level. Location-specific coordinates are not provided.

You may also use the 911 Call Data to gain further insights & to improve your ML modeling.

Your task is to answer one or more of the following questions listed below: 

* What formula would you use for a metric to rank the safety of each neighborhood for a student, a family with a young child below the age of 15, and an elderly person? What would be the ranking result when this formula is used for each category of people? 

1. Clean data in Analysis.R;
2. Assign different weights(scale from 0 to 10) to crime types based on severity they imposed on each category of people;
3. Create a static evaluation formula: $\sum$ occurances * severity weight;
4. Import .CSV file to Microsoft SQL server;
5. Use query to come up with 3 different tables for each category of people containing neighborhood names, evaluated values, and ranking.

* To what extent and accuracy can we predict the level of change in crime for a neighborhood?
* What unique statistics and patterns were you able to identify in Seattle’s crime? 
