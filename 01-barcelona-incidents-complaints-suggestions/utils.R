############
### Packages
############
library(R.utils)
library(readr)
library(shinydashboard)
library(shinyjs)
library(shinycssloaders)
library(dplyr)
library(data.table)
library(DT)
library(lubridate)
library(highcharter)
library(tidyr)

############
### Constants
############
target_columns <- c(
  "TIPUS",
  "AREA",
  "ELEMENT",
  "DETALL",
  "DIA_DATA_ALTA",
  "MES_DATA_ALTA",
  "ANY_DATA_ALTA",
  "DIA_DATA_TANCAMENT",
  "MES_DATA_TANCAMENT",
  "ANY_DATA_TANCAMENT",
  "DISTRICTE",
  "BARRI",
  "TIPUS_VIA",
  "CARRER",
  "NUMERO",
  "LONGITUD",
  "LATITUD",
  "SUPORT",
  "CANALS_RESPOSTA"
)

############
### Source Functions
############
sourceDirectory("functions/")

############
### Data
############
filenames <- list.files("data", full.names = TRUE)
data_barcelona <- Reduce(rbind, lapply(filenames, data_reader))

############
### Source Dashboards
############
sourceDirectory("dashboards/")
