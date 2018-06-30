##############################
### UI
##############################

source("utils.R")

# Header
header <- dashboardHeader(title = "Barcelona - Complains",
                          tags$li(a(href = "http://opendata-ajuntament.barcelona.cat/data/en/dataset/iris",
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
