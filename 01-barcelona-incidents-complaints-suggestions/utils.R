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

numeric_columns <- c(
  "MES_DATA_ALTA",
  "ANY_DATA_ALTA",
  "DIA_DATA_TANCAMENT",
  "MES_DATA_TANCAMENT",
  "ANY_DATA_TANCAMENT",
  "NUMERO",
  "LONGITUD",
  "LATITUD"
)

catalan_months <- c(
  "Gener",
  "Febrer",
  "Març",
  "Abril",
  "Maig",
  "Juny",
  "Juliol",
  "Agost",
  "Septembre",
  "Octubre",
  "Novembre",
  "Decembre"
)

catalan_days_of_week <- c(
  "Dilluns",
  "Dimarts",
  "Dimecres",
  "Dijous",
  "Divendres",
  "Dissabte",
  "Diumenge"
)

min_year <- 2014
max_points_in_map <- 1000
max_top_n_in_charts <- 15

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
