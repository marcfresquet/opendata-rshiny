##############################
### SERVER
##############################

shinyServer(function(input, output, session) {
  
  # EDA
  server_eda(input, output, session)
  
  # Contacts
  server_contacts(input, output, session)
  
  # District
  server_district(input, output, session)
  
  # Map
  server_map(input, output, session)
  
})
