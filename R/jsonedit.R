#' View \code{lists} with \href{https://github.com/josdejong/jsoneditor}{jsoneditor}
#'
#' \code{jsoneditor} provides a flexible and helpful interactive tree-like view of \code{lists}
#'   or really any R dataset that can be represented as \code{JSON}.
#'   Eventually, this could become a very nice way to not only view but also modify R data using
#'   Shiny.
#'
#' @param listdata \code{list} data to view.  Although designed for \code{lists}, \code{listdata} can
#'          be any data source that can be rendered into \code{JSON} with \code{jsonlite}.
#' @param mode \code{string} for the initial view from \code{modes}.  \code{'tree'} is the default.
#' @param modes \code{string} \code{c('code', 'form', 'text', 'tree', 'view')} will be the default, since
#'          these are all the modes currently supported by \code{jsoneditor}.
#' @param ... \code{list} of other options for \code{jsoneditor}.  This is a temporary way
#'          of trying other options in \code{jsoneditor}.  In the future, this will be eliminated
#'          in favor of specific, more self-documenting and helpful arguments.
#' @param width integer in pixels defining the width of the \code{div} container.
#' @param height integer in pixels defining the height of the \code{div} container.
#' @examples
#' \dontrun{
#'    library(listviewer)
#'
#'    # using the data from the jsoneditor simple example
#'    #  in R list form
#'    jsonedit(
#'      list(
#'        array = c(1,2,3)
#'        ,boolean = TRUE
#'        ,null = NULL
#'        ,number = 123
#'        ,object = list( a="b", c="d" )
#'        ,string = "Hello World"
#'      )
#'    )
#' }
#' @import htmlwidgets
#'
#' @export
jsonedit <- function(
    listdata = NULL
    , mode = 'tree'
    , modes = c('code', 'form', 'text', 'tree', 'view')
    , ...
    , width = NULL
    , height = NULL
) {

  # forward options using x
  x = list(
    data = listdata
    ,options = list(mode = mode, modes = modes, ...)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'jsonedit',
    x,
    width = width,
    height = height,
    package = 'listviewer'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
jsoneditOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'jsonedit', width, height, package = 'listviewer')
}

#' Widget render function for use in Shiny
#'
#' @export
renderJsonedit <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, jsoneditOutput, env, quoted = TRUE)
}
