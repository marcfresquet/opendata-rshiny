##############################
### SERVER
##############################

shinyServer(function(input, output, session) {
  
  # EDA
  server_eda(input, output, session)
  
  # Map
  server_map(input, output, session)
  
})
