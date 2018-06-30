##############################
### EDA Dashboard
##############################

# id
eda_dashboard_id = "eda_dashboard"

# Sidebar
sidebar_eda <- menuItem("EDA", tabName = eda_dashboard_id, icon = icon("dashboard"))

# Body
body_eda <- tabItem(tabName = eda_dashboard_id,
  fluidRow(
    useShinyjs()
  )
)
