#' Shiny Gadget for 'jsonedit'
#'
#' Provides a \href{http://shiny.rstudio.com/articles/gadgets.html}{Shiny gadget}
#'   interface for \code{jsonedit} to interactively edit and return the
#'   changes for use in R.
#'
#' @param height,width any valid \code{CSS} size unit for the
#'          height and width of the gadget
#' @param ... arguments for \code{\link{jsonedit}}
#'
#' @example ./inst/examples/examples_gadget.R
#' @export
jsonedit_gadget <- function(..., height = NULL, width = NULL) {
  # modeled after chemdoodle gadget
  #  https://github.com/zachcp/chemdoodle/blob/master/R/chemdoodle_sketcher_gadgets.R
  if(interactive()) {
    if(!requireNamespace("miniUI")) {
      userChoice <- readline(prompt = "The package \"miniUI\" is required but not installed. Do you wish to install it? (y/n or ENTER/ESC):")
      if(tolower(userChoice) %in% c("y", "", "yes")) {
        utils::install.packages("miniUI") #shiny is also installed with miniUI
      }
    }
  }
  stopifnot(requireNamespace("miniUI"), requireNamespace("shiny"))
  ui <- miniUI::miniPage(
    miniUI::miniContentPanel(jsonedit(...), height=NULL, width=NULL),

    miniUI::gadgetTitleBar("Edit Data", right = miniUI::miniTitleBarButton("done", "Done", primary = TRUE)),

    htmltools::tags$script('
document.getElementById("done").onclick = function() {
  var listdata = JSON.parse(
    HTMLWidgets.find(".jsonedit").editor.getText()
  );
  Shiny.onInputChange("jsoneditordata", listdata);
};
'
    )
  )

  server <- function(input, output, session) {
    shiny::observeEvent(input$done, { shiny::stopApp(input$jsoneditordata) })
    shiny::observeEvent(input$cancel, { shiny::stopApp (NULL) })
  }

  shiny::runGadget(
    ui,
    server,
    viewer =  shiny::dialogViewer("View and Edit Data"),
    stopOnCancel = FALSE
  )
}

#' jsoneditAddin
#'
#' This uses the gadget as an addin, so you can select objects then
#'   activate the addin in RStudio either via menu or a hotkey.
#'
#' @keywords internal
jsoneditAddin <- function(){
  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text

  obj <- get(text, envir = .GlobalEnv)

  jsonedit_gadget(obj)

}
