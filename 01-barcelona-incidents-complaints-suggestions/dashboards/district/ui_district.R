##############################
### District Dashboard
##############################

# id
district_dashboard_id = "district_dashboard"

# Sidebar
sidebar_district <- menuItem("Incidències per districte", tabName = district_dashboard_id, icon = icon("home"))

# Body
body_district <- tabItem(tabName = district_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(12,
           withSpinner(highchartOutput("incidents_per_district")),
           withSpinner(highchartOutput("incidents_per_district_and_area"))
    )
  )
)
