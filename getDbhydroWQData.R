library(lubridate)
rm(list=ls())
source("SFWMD.DBHYDRO.Data.R")
StationNames=c("G329B","G330D","G333C","G334",
               "G380B","G384B", "G384B","G381B")
BasinPosition=c("STA2C1Inflow","STA2C1Ouflow","STA2C3Inflow","STA2C3Outflow",
                "STA34C3AInflow","STA34C3AOutflow", "STA34C3BInflow","STA34C3BOutflow")
#lat lon in ddmmss.sss
coordinates=list(c(262515.146,802923.299),
                 c(262246.04,803123.691),
                 c(262514.706,803242.059),
                 c(262245.632,803141.361),
                 c(262345.49,803855.421),
                 c(262240.7,803857.2),
                 c(262240.7,803857.2),
                 c(262135.102,803855.68))


date_start=mdy("01-01-2016")
date_end = mdy("01-01-2107")
varids = c(1:100)

#creates 8 data frames for each of the cells
for (i in 1:8){
df=SFWMD.DBHYDRO.Data.WQ(date_start,date_end,StationNames[i],varids)
assign(BasinPosition[i],df)
}


