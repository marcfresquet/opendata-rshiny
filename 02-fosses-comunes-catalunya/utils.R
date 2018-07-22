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
library(leaflet)
library(stringr)

############
### Constants
############
target_columns <- c(
  "Titol",
  "X",
  "Y",
  "Desapareguda",
  "Bandol",
  "TipusFossa",
  "Notes",
  "Font",
  "Documentacio",
  "NumRestes",
  "Municipi",
  "Comarca",
  "IdCategoria",
  "Fitxa",
  "Excavades"
)

############
### Source Functions
############
sourceDirectory("functions/")

############
### Data
############
data_fosses <- data_reader("data/Fosses_comunes_a_Catalunya.csv")

############
### Source Dashboards
############
sourceDirectory("dashboards/")
