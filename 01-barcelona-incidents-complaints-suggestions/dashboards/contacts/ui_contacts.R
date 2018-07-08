##############################
### Contacts Dashboard
##############################

# id
contacts_dashboard_id = "contacts_dashboard"

# Sidebar
sidebar_contacts <- menuItem("Detall dels contactes", tabName = contacts_dashboard_id, icon = icon("dashboard"))

# Body
body_contacts <- tabItem(tabName = contacts_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(12,
      selectInput("tipus_contact_filter", "Tipus", choices = unique(data_barcelona$TIPUS))
    ),
    column(12,
      withSpinner(highchartOutput("area_grouped")),
      withSpinner(highchartOutput("element_grouped")),
      withSpinner(highchartOutput("detall_grouped"))
    )
  )
)
