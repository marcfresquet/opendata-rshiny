##############################
### UI
##############################

source("utils.R")

# Header
header <- dashboardHeader(title = "Fosses comunes CAT",
                          tags$li(a(href = "https://github.com/marcfresquet/opendata-rshiny/tree/master/02-fosses-comunes-catalunya",
                                    icon("github"),
                                    title = "marcfresquet/opendata-rshiny"),
                                  class = "dropdown"))

# Sidebar
sidebar <- dashboardSidebar(
  collapsed = TRUE,
  sidebarMenu(list(
    sidebar_map
  ))
)

# Body
body <- dashboardBody(
  tabItems(
    body_map
  )
)

# UI
dashboardPage(header, sidebar, body)
