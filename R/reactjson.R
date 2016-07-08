#' Edit R Data with 'react-json'
#'
#' @import htmlwidgets
#'
#' @export
#' @example inst/examples/examples_reactjson.R
reactjson <- function(
  json = list(),
  width = NULL, height = NULL, elementId = NULL
) {

  if(!require(reactR)){
    stop("please devtools::install_github('timelyportfolio/reactR')", call.=FALSE)
  }

  # forward options using x
  x = list(
    json = json
  )

  # create widget
  hw <- htmlwidgets::createWidget(
    name = 'reactjson',
    x = x,
    width = width,
    height = height,
    package = 'listviewer',
    elementId = elementId
  )

  hw$dependencies <- list(
    reactR::html_dependency_react(),
    htmltools::htmlDependency(
      name = "react-json",
      version = "0.0.1",
      src = system.file("htmlwidgets/reactjson/dist", package="listviewer"),
      script = "Json.js",
      stylesheet = c("react-json.css")
    )
  )
  hw
}

#' Shiny bindings for reactjson
#'
#' Output and render functions for using reactjson within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a reactjson
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name reactjson-shiny
#'
#' @export
reactjsonOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'reactjson', width, height, package = 'listviewer')
}

#' @rdname reactjson-shiny
#' @export
renderReactjson <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, reactjsonOutput, env, quoted = TRUE)
}
