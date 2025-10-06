#Paula Cardozo da Silva, NUSP 8803299
#Dados do Pico do Jaraguá 01/01/2019 - 31/12/2019

o3 <- read.table("A1_POLUAR_Data/PJ_O3_2019.csv", header = T, 
                 sep = ";", dec = ".", na.string = -9999, 
                 fileEncoding = "Latin1", check.names = F)
no2 <- read.table("A1_POLUAR_Data/PJ_NO2_2019.csv", header = T,
                  sep = ";", dec = ".", fileEncoding = "Latin1", 
                  na.string = -9999, check.names = F)
no <- read.table("A1_POLUAR_Data/PJ_NO_2019.csv", header = T,
                 sep = ";", dec = ".", fileEncoding = "Latin1", 
                 na.string = -9999, check.names = F)

head(o3)
head(no2)
head(no)

#Filtrando valores

o3_f <- subset(o3, Parâmetro == "O3 (Ozônio)")
no2_f <- subset(no2, Parâmetro == "NO2 (Dióxido de Nitrogênio)")
no_f <- subset(no, Parâmetro == "NO (Monóxido de Nitrogênio)")
str(o3_f)

#Organizando a data o3

o3_f$date <- as.POSIXct(strptime(o3_f$DataHora, format = "%d/%m/%Y%H:%M"))
o3_f <- o3_f[c("date", "Valor")]
names(o3_f)[2] <- "o3"

#Organizando a data no2

no2_f$date <- as.POSIXct(strptime(no2_f$DataHora, format = "%d/%m/%Y%H:%M"))
no2_f <- no2_f[c("date", "Valor")]
names(no2_f)[2] <- "no2"

#Organizando a data no

no_f$date <- as.POSIXct(strptime(no_f$DataHora, format = "%d/%m/%Y%H:%M"))
no_f <- no_f[c("date", "Valor")]
names(no_f)[2] <- "no"

library(openair)

#summaryPlot

summaryPlot(o3_f)
summaryPlot(no2_f)
summaryPlot(no_f)

#timePlot
timePlot(o3_f, pollutant = "o3")
timePlot(no2_f, pollutant = "no2")
timePlot(no_f, pollutant = "no")

#timevariation

timeVariation(o3_f, pollutant = "o3")
timeVariation(no2_f, pollutant = "no2")
timeVariation(no_f, pollutant = "no")

#timevariation com dados juntos
library(qualR)
pj_o3_no2_no <- cetesb_retrieve_param("paulacardozo@usp.br", "poluar", 
                                      c("O3", "NO2", "NO"), "Pico do Jaraguá", 
                                      "01/01/2019", "31/12/2019")
timeVariation(pj_o3_no2_no, pollutant = c("o3", "no2", "no"))
