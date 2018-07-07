##############################
### EDA Dashboard
##############################

# id
eda_dashboard_id = "eda_dashboard"

# Sidebar
sidebar_eda <- menuItem("Exploració temporal", tabName = eda_dashboard_id, icon = icon("calendar"))

# Body
body_eda <- tabItem(tabName = eda_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(12,
      valueBoxOutput("box_n_rows", width = 6),
      valueBoxOutput("box_n_years", width = 6)
    ),
    column(12,
      withSpinner(highchartOutput("events_per_year")),
      withSpinner(highchartOutput("events_per_month")),
      withSpinner(highchartOutput("events_per_day_of_week"))
    )
  )
)
