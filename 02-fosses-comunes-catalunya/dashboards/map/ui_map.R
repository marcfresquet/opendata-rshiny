##############################
### Map Dashboard
##############################

# id
map_dashboard_id = "map_dashboard"

# Sidebar
sidebar_map <- menuItem("Mapa", tabName = map_dashboard_id, icon = icon("globe"))

# Widget options
selectizeInput_opts <- list(plugins=list('remove_button'))

# Body
body_map <- tabItem(tabName = map_dashboard_id,
  fluidRow(
    useShinyjs(),
    column(3,
     wellPanel(
       h3("Filtres"),
       selectizeInput("municipi_filter", "Municipi", unique(data_fosses$Municipi), multiple = TRUE, options = selectizeInput_opts),
       selectInput("bandol_filter", "Bàndol", c("Mostra tot", "Republicà", "Rebel", "Ambdós bàndols"), multiple = FALSE),
       selectInput("tipus_fossa_filter", "Tipus Fossa", na.omit(c("Mostra tot" , unique(data_fosses$TipusFossa))), multiple = FALSE),
       selectInput("excavades_filter", "Excavades", c("Mostra tot" , unique(data_fosses$Excavades)), multiple = FALSE)
     )
    ),
    column(9,
     h4("Fes click a una fossa per veure més detalls"),
     withSpinner(leafletOutput("fosses_map", width="100%", height="1000px"))
    )
  )
)
