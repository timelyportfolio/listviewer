#' listviewer htmlwidget using \href{https://github.com/josdejong/jsoneditor}{jsoneditor}
#'
#' \code{jsoneditor} provides a flexible and helpful interactive tree-like view of \code{lists}
#'   or really any R dataset that can be represented as \code{JSON}.
#'   Eventually, this could become a very nice way to not only view but also modify R data using
#'   Shiny.
#'
#' @import htmlwidgets
#'
#' @export
jsonedit <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
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
