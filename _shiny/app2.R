library(shiny)
#if(!require(shinysurveys)){install.packages("shinysurveys",force=T)}
#if(!require(googlesheets4)){install.packages("googlesheets4")}
invisible("https://www.jdtrat.com/blog/connect-shiny-google/")

#googledrive::drive_auth() 
#googlesheets4::gs4_auth() 

#list.files( paste0(getwd(),"/.secrets/"))
# google_df <-
# googlesheets4::gs4_create(name = "encuesta", 
#                           # Create a sheet called main for all data to 
#                           # go to the same place
#                           sheets = "main", locale = "es_ES")
# googledrive::drive_get("encuesta")$id
# 


# Define shiny server
server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    response_data <- getSurveyData()
    
    # Read our sheet
    values <- read_sheet(ss = sheet_id, 
                         sheet = "main")
    
    # Check to see if our sheet has any existing data.
    # If not, let's write to it and set up column names. 
    # Otherwise, let's append to it.
    
    if (nrow(values) == 0) {
      sheet_write(data = response_data,
                  ss = sheet_id,
                  sheet = "main")
    } else {
      sheet_append(data = response_data,
                   ss = sheet_id,
                   sheet = "main")
    }
    
  })
  
}

#https://docs.google.com/spreadsheets/d/1URwpG1Hn6S1RVGW5-Kj-AoqWx1X0hRTN2bCDruEchgY/edit?usp=sharing
library(shiny)
library(shinysurveys)
library(googledrive)
library(googlesheets4)

options(
  # whenever there is one account token found, use the cached token
  gargle_oauth_email = TRUE,
  # specify auth tokens should be stored in a hidden directory ".secrets"
  gargle_oauth_cache = "./secrets"
)

# Get the ID of the sheet for writing programmatically
# This should be placed at the top of your shiny app
sheet_id <- drive_get("prueba_ciencia_datos")$id

# Define questions in the format of a shinysurvey
survey_questions <- data.frame(
  question = c("d.¿Cuáles son sus expectativas del curso?"
              ),
  option = c(rep("Indique",1)),
  input_type = c("text"),#,"mc"
  input_id = c("a"),
  dependence = NA,
  dependence_value = NA,
  required = T
)
 nested_questions <- survey_questions %>% 
   dplyr::group_by(question) %>% 
   tidyr::nest() %>%
   dplyr::ungroup()
# 
 multiQuestions <- nested_questions %>%
   dplyr::mutate(page = c(1))

# Define shiny UI
ui <- fluidPage(
  surveyOutput(tidyr::unnest(multiQuestions),
               survey_title = "Tamizaje Ciencia de datos",
               survey_description = "Servirá para saber cuáles son sus intereses y cuánto saben de las temáticas a abordar. No le tomará más de 5 minutos.",
               theme = "steelblue")
)

# Define shiny server
server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    response_data <- getSurveyData()
    
    # Read our sheet
    values <- read_sheet(ss = sheet_id, 
                         sheet = "main")
    
    # Check to see if our sheet has any existing data.
    # If not, let's write to it and set up column names. 
    # Otherwise, let's append to it.
    
    if (nrow(values) == 0) {
      sheet_write(data = response_data,
                  ss = sheet_id,
                  sheet = "main")
    } else {
      sheet_append(data = response_data,
                   ss = sheet_id,
                   sheet = "main")
    }
   
    showModal(modalDialog(
      title = "Muchas gracias por la respuesta."
    ))  
     
  })
  
}

# Run the shiny application
shinyApp(ui, server)

shinyApp(ui = ui, server = server)