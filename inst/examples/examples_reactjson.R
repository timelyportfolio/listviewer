# requires dev version of listviewer
# devtools::install_github("timelyportfolio/listviewer@feature/react-json")
library(listviewer)

# use reactR for React dependencies
# devtools::install_github("timelyportfolio/reactR")
library(reactR)

reactjson()

reactjson(head(mtcars,4))

library(shiny)

shinyApp(
  ui = reactjson(
    list(x=1,msg="react+r+shiny",opts=list(use_react=FALSE)),
    elementId = "json1"
  ),
  server = function(input, output, session){
    observeEvent(
      input$json1_change,
      str(input$json1_change)
    )
  }
)
