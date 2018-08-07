library(tidyverse)
library(dplyr)
library(curl)
library(devtools)
library(rga)
# install.packages("devtools")
library(devtools)

# install_github("rga", "skardhamar")
library(rga)

# Save the GA instance locally. it'll open your browser
# and prompt for auth once. reuse the local auth file to
# avoid re-authenticating later.
rga.open(instance="ga", where="ga.rga") # may work not from the 1st run, try again

options(RCurlOptions = list(verbose = FALSE, capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))
rga.open(instance="ga", where="~/ga.rga")

# let's set up the parameters in a way that we can easily find and change them for future re-runs of the analysis:
start_date <- "2012-06-01"
end_date <- "2013-06-01"
# end_date <- "2013-06-01"
# start.date = first_date, end.date = "yesterday
# todaydate <- Sys.Date()

# работающий вариант на 7 метрик
metrics <- "ga:sessionDuration,ga:sessions,ga:bounces,ga:newusers"
dimensions <- "ga:date,ga:country,ga:city"

# dimensions <- "ga:landingPagePath,ga:date,ga:country"

sort <- "ga:date,ga:country"
ids <- "ga:XXXXXXXX"

outfile <- "data/ga.csv"

# swap `XXXXXX` for your profile_id
src <- ga$getData(
  "ga:33291245",
  start.date = start_date,
  end.date = end_date,
  metrics = metrics, 
  dimensions = dimensions,
  sort = sort,
  batch = TRUE # in case there are more 10000 entries
) 


View(src)
str(src)
summary(src)

# In order to get the date that contains the first data, use the function:
ga$getFirstDate(ids) 


write.csv(src, file=outfile) 
# row.names = F, quote = F, sep = ";")