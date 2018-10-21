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
      h4("Dades actualitzades fins al 2018/09/30"),
      valueBoxOutput("box_n_rows", width = 6),
      valueBoxOutput("box_n_years", width = 6)
    ),
    tabsetPanel(
      tabPanel("Exploració global",
         column(12,
                withSpinner(highchartOutput("events_per_year")),
                withSpinner(highchartOutput("events_per_month")),
                withSpinner(highchartOutput("events_per_day_of_week"))
         )
      ),
      tabPanel("Dia a dia", 
        column(12,
               withSpinner(highchartOutput("days_until_closed"))
        )
      )
    )
  )
)
