##############################
### UI
##############################

source("utils.R")

# Header
header <- dashboardHeader(title = "Contactes Aj. BCN",
                          tags$li(a(href = "https://github.com/marcfresquet/opendata-rshiny/tree/master/01-barcelona-incidents-complaints-suggestions",
                                    icon("github"),
                                    title = "marcfresquet/opendata-rshiny"),
                                  class = "dropdown"))

# Sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(list(
    sidebar_eda,
    sidebar_map,
    sidebar_district,
    sidebar_contacts
  ))
)

# Body
body <- dashboardBody(
  tabItems(
    body_eda,
    body_map,
    body_district,
    body_contacts
  )
)

# UI
dashboardPage(header, sidebar, body)
