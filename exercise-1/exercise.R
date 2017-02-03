### Exercise 1.0 ###

# Load the httr and jsonlite libraries for accessing data
library("httr")
library("jsonlite")
library("dplyr")
## For these questions, look at the API documentation to identify the appropriate endpoint and information.
## Then send GET() request to fetch the data, then extract the answer to the question
response <- GET("http://data.unhcr.org/api/stats/time_series_years.json")
body <- content(response,"text")
years <- fromJSON(body)
# For what years does the API have statistical data?
print(years)
# What is the "country code" for the "Syrian Arab Republic"?
response2 <- GET("http://data.unhcr.org/api/countries/list.json")
countries <- fromJSON(content(response2,"text"))
View(countries)
code <- filter(countries, name_en == "Syrian Arab Republic") %>% select(country_code)
print(code)

# How many persons of concern from Syria applied for residence in the USA in 2013?
# Hint: you'll need to use a query parameter
# Use the `str()` function to print the data of interest
# See http://www.unhcr.org/en-us/who-we-help.html for details on these terms
response3 <- GET("http://data.unhcr.org/api/stats/persons_of_concern.json?year=2013&country_of_origin=AFG&country_of_residence=CHE",query=(list(year=2013,country_of_origin="SYR",country_of_residence="USA")))
poc <- fromJSON(content(response3,"text"))
str(poc)

## And this was only 2013...


# How many *refugees* from Syria settled the USA in all years in the data set (2000 through 2013)?
# Hint: check out the "time series" end points
response4 <- GET("http://data.unhcr.org/api/stats/time_series_all_years.json?population_type_code=AS&country_of_origin=AFG&country_of_residence=CHE",query=(list(population_type_code="RF",country_of_origin="SYR",country_of_residence="USA")))
poc <- fromJSON(content(response4,"text"))
print(poc)
# Use the `plot()` function to plot the year vs. the value.
# Add `type="o"` as a parameter to draw a line
plot(poc$year,poc$value,type="o")


# Pick one other country in the world (e.g., Turkey).
# How many *refugees* from Syria settled in that country in all years in the data set (2000 through 2013)?
# Is it more or less than the USA? (Hint: join the tables and add a new column!)
# Hint: To compare the values, you'll need to convert the data (which is a string) to a number; try using `as.numeric()`



## Bonus (not in solution):
# How many of the refugees in 2013 were children (between 0 and 4 years old)?


## Extra practice (but less interesting results)
# How many total people applied for asylum in the USA in 2013?
# - You'll need to filter out NA values; try using `is.na()`
# - To calculate a sum, you'll need to convert the data (which is a string) to a number; try using `as.numeric()`


## Also note that asylum seekers are not refugees
