#' Edit R Data with 'react-json'
#'
#' @param listdata \code{list} or \code{String} data to view.  Although designed for \code{lists}, \code{listdata} can
#'          be any data source that can be rendered into \code{JSON} with \code{jsonlite}.  Alternately,
#'          \code{listdata} could be a \code{String} of valid \code{JSON}.  This might be helpful
#'          when dealing with an API response.
#' @param width integer in pixels defining the width of the \code{div} container.
#' @param height integer in pixels defining the height of the \code{div} container.
#' @param elementId character to specify valid \code{CSS} id of the
#'          htmlwidget for special situations in which you want a non-random
#'          identifier.
#'
#' @import htmlwidgets
#'
#' @export
#' @example inst/examples/examples_reactjson.R
reactjson <- function(
  listdata = list(),
  width = NULL, height = "100%", elementId = NULL
) {

  if(!requireNamespace("reactR")){
    stop("please devtools::install_github('timelyportfolio/reactR')", call.=FALSE)
  }

  listdata <- list_proper_form(listdata)

  # forward options using x
  x = list(
    data = listdata
  )

  # create widget
  hw <- htmlwidgets::createWidget(
    name = 'reactjson',
    x = x,
    width = width,
    height = height,
    #sizingPolicy = htmlwidgets::sizingPolicy(viewer.suppress=TRUE),
    package = 'listviewer',
    elementId = elementId
  )

  hw$dependencies <- list(
    htmltools::htmlDependency(
      name = "core-js",
      version = "2.5.1",
      src = system.file("htmlwidgets/core-js/dist", package="listviewer"),
      script = "shim.min.js",
      all_files = FALSE
    ),
    reactR::html_dependency_react(),
    htmltools::htmlDependency(
      name = "react-json-view",
      version = "0.1.0",
      src = system.file("htmlwidgets/reactjson/dist", package="listviewer"),
      script = "main.js",
      all_files = FALSE

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
