

#### INTERACTIVE MAP OF WORLD POPULATION 1950-2010 ####
#### Marco Ghislanzoni, 2013
#### http://marcoghislanzoni.com

# Load the rworldmap library
library(rworldmap)
# And the manipulate library
library(manipulate)

# Read world population data by country 1950 - 2010
# Source: WPP2012_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.xls
# Downloaded from: http://esa.un.org/wpp/Excel-Data/population.htm
# Converted to CSV in Excel
# Assumes the file is in the current working directory
data <- read.csv("Book1 (1).csv", header=TRUE)

# Convert country code to chr. Originally is an int.


# Join the world population data with the world map, matching by country code
# Note: not all countries are matched!
data.map <- joinCountryData2Map(data, joinCode = "NAME", nameJoinColumn = "Country")

# Plot a sample map for 2010's population data
# mapCountryData(data.map, nameColumnToPlot="X2010")

# Plot an interactive map where you can change the displayed Year from 1950 to 2010 with a slider
a <- mapCountryData(data.map,
               colourPalette = c('blue','yellow','green','orange','red')  , catMethod = c(0,500,1000,2000,5000,50000) ,nameColumnToPlot="Fans",borderCol = "gray",aspect = 1,addLegend = FALSE,mapTitle = "Fans by countries"
               
)
#add a modified legend using the same initial parameters as mapCountryData               
do.call(addMapLegendBoxes,c( a, x= "bottomleft", horiz = FALSE, title = "Fans" ,cex = 0.60,pt.cex = 1
                             #list(legendText=c('Below 10', '10-18','18-42','42-98','98-199','199-678','678 and above'))
))

#do.call( addMapLegend, c( a, legendLabels = "all", legendWidth = 0.5 ))

### END OF SOURCE CODE ####
