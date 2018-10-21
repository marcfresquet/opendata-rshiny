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
    sidebar_contacts,
    sidebar_district,
    sidebar_map
  ))
)

# Body
body <- dashboardBody(
  tabItems(
    body_eda,
    body_contacts,
    body_district,
    body_map
  )
)

# UI
dashboardPage(header, sidebar, body)
