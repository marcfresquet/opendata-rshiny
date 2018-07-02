##############################
### UI
##############################

source("utils.R")

# Header
header <- dashboardHeader(title = "Contactes Aj. BCN",
                          tags$li(a(href = "http://opendata-ajuntament.barcelona.cat/data/ca/dataset/iris",
                                    icon("power-off"),
                                    title = "OpenData Barcelona"),
                                  class = "dropdown"))

# Sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(list(
    sidebar_eda
  ))
)

# Body
body <- dashboardBody(
  tabItems(
    body_eda
  )
)

# UI
dashboardPage(header, sidebar, body)
