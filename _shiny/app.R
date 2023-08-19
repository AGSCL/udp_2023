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
sheet_id <- drive_get("encuesta")$id

# Define questions in the format of a shinysurvey
survey_questions <- data.frame(
  question = c("a.¿Cuál es su nombre completo?",
               "b.¿Cuántos años de experiencia tiene en R? (si es menos de un año, indique decimal)",
               "c.¿Cómo aprendió a utilizar R?",
               "d.¿Cuáles son sus expectativas del curso?",
               rep("e.¿Qué aspecto de los contenidos le interesó más?",6),
               rep("f.Instale el paquete ('ggplot2'), busque los datos titulados 
                   '2d Density Estimate Of Old Faithful Data' y ocupe la función 'qplot'
                   para obtener la densidad ('density'). ¿Qué gráfico representa el resultado de esta operación?",3),
              rep("g.Relacionado con el signo '+' en la lógica detrás de ggplot",4),
              rep("h.Si le comparten un .RData, es imposible que tenga más de una base de datos en su interior",2),
              rep("i.El archivo .Rproj sirve para guardar bases de datos y otros objetos en su interior",2)
              ),
  option = c(rep("Indique",4),"Trabajar con Proyectos en R", "Investigación reproducible", "Paquetes, funciones,etc.", "Estadística descriptiva", "Tidyverse","Ggplot",
             "Una distribución sesgada a la derecha","Una distribución simétrica","Una distribución bimodal",
             "Va después de un componente de un gráfico", "Sirve para añadir un componente adicional", "Estos componentes también se llaman 'capas'","Todas las anteriores",
              rep(c("Verdadero","Falso"),2)),
  input_type = c("text","numeric","text","text",rep("select",6),rep("mc",3),rep("mc",4),rep("y/n",2),rep("y/n",2)),#,"mc"
  input_id = c("a", "b","c", "d",rep("e",6),rep("f",3), rep("g",4),rep("h",2),rep("i",2)),
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
   dplyr::mutate(page = c(
     rep(1, 3),
     rep(2,6)
#     rep(3, 6))
   ))

# Define shiny UI
ui <- fluidPage(
  surveyOutput(tidyr::unnest(multiQuestions),
               survey_title = "Tamizaje de Estadística Aplicada y Procesamiento de Datos con R",
               survey_description = "Servirá para saber cuáles son sus intereses y cuánto saben de las temáticas a abordar. No le tomará más de 5 minutos.",
               theme = "#DD3333")
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
      title = "Muchas gracias por la respuesta. Esto permitirá adaptar el taller",
      "Cualquier duda o consulta al módulo CANVAS asignado"
    ))  
     
  })
  
}

# Run the shiny application
shinyApp(ui, server)

shinyApp(ui = ui, server = server)