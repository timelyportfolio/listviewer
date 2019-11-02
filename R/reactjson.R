#' Edit R Data with 'react-json'
#'
#' @param listdata \code{list} or \code{String} data to view.  Although designed for \code{lists}, \code{listdata} can
#'          be any data source that can be rendered into \code{JSON} with \code{jsonlite}.  Alternately,
#'          \code{listdata} could be a \code{String} of valid \code{JSON}.  This might be helpful
#'          when dealing with an API response.
#' @param name \code{string} name of the root node.  Default is \code{"root"}.
#' @param theme \code{string} name of the theme.  Default is \code{"rjv-default"}.
#' @param iconStyle \code{string} shape for the expand/collapse icon. Options are circle,
#'          triangle, and square with the default as \code{"circle"}.
#' @param indentWidth \code{integer} for the indent width for nested objects. Default is \code{4}.
#' @param collapsed \code{logical} or \code{integer}.  Use \code{logical} to expand/collapse all nodes.
#'          Use \code{integer} to specify the depth at which to collapse.
#' @param collapseStringsAfterLength \code{integer} for the length at which strings will be cut off
#'          Collapsed strings are followed by an ellipsis. String content can be expanded and
#'          collapsed by clicking on the string value.
#' @param groupArraysAfterLength \code{integer} for the count at which arrays will be displayed in groups.
#'          Groups are displayed with bracket notation and can be expanded and collapsed.
#'          by clicking on the brackets.
#' @param enableClipboard \code{logical} whether the user can copy objects and arrays
#'          clicking on the clipboard icon. Copy callbacks are supported. Default is \code{TRUE}.
#' @param displayObjectSize \code{logical} whether or not objects and arrays are labeled with size.
#'          Default is \code{TRUE}.
#' @param displayDataTypes \code{logical} whether or not data type labels prefix values.
#'          Default is \code{TRUE}.
#' @param onEdit,onAdd,onDelete,onSelect \code{htmlwidgets::JS} or \code{logical}
#'          to control behavior on edit, add, delete, and select.  If \code{htmlwidgets::JS}
#'          function is provided, then the function will be performed on each event.  If
#'          \code{logical} then \code{TRUE} means that the event will be passed to Shiny and
#'          \code{FALSE} will disable the behavior.  The default is \code{TRUE}.
#' @param sortKeys \code{logical} whether or not to sort object keys.  Default is \code{FALSE}.
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
  name = "root",
  theme = "rjv-default",
  iconStyle = c("circle", "triangle", "square"),
  indentWidth = 4,
  collapsed = FALSE,
  collapseStringsAfterLength = FALSE,
  groupArraysAfterLength = 100,
  enableClipboard = TRUE,
  displayObjectSize = TRUE,
  displayDataTypes = TRUE,
  onEdit = TRUE,
  onAdd = TRUE,
  onDelete = TRUE,
  onSelect = TRUE,
  sortKeys = FALSE,
  width = NULL, height = NULL, elementId = NULL
) {

  if(!requireNamespace("reactR")){
    stop("please devtools::install_github('timelyportfolio/reactR')", call.=FALSE)
  }

  listdata <- list_proper_form(listdata)

  # forward options using x
  x = list(
    data = listdata,
    name = name,
    theme = theme,
    iconStyle = iconStyle[1],
    indentWidth = indentWidth,
    collapsed = collapsed,
    collapseStringsAfterLength = collapseStringsAfterLength,
    groupArraysAfterLength = groupArraysAfterLength,
    enableClipboard = enableClipboard,
    displayObjectSize = displayObjectSize,
    displayDataTypes = displayDataTypes,
    onEdit = onEdit,
    onAdd = onAdd,
    onDelete = onDelete,
    onSelect = onSelect,
    sortKeys = sortKeys
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
      version = "1.19.1",
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
