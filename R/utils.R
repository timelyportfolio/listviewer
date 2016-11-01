#' @keywords internal
named_vec2list <- function(listx){
  # to avoid toJSON keep_vec_names warnings
  #  with named vectors
  #  convert named vectors to list
  #  see https://github.com/timelyportfolio/listviewer/issues/10
  if(
    !inherits(listx,"list") &&
    is.null(dim(listx)) &&
    !is.null(names(listx))
  ){
    listx <- as.list(listx)
  }
  return(listx)
}

#' @keywords internal
list_proper_form <- function(listdata){
  if(inherits(listdata,"list")){
    listdata <- rapply(listdata,named_vec2list,how="list")
  }
  listdata
}

#' Recurse Over Nested Lists
#'
#' Like \code{rapply} but recurses over nested lists and
#' retain \code{attributes} and \code{names}.
#'
#' @param l \code{list} over which we would like to recurse
#' @param func \code{function} to apply to the list
#' @param ... arguments for the \code{func}
#'
#' @keywords internal
recurse <- function(l, func, ...) {
l <- func(l, ...)
if(is.list(l) && length(l)>0){
  lapply(
    l,
    function(ll){
      recurse(ll, func, ...)
    }
  )
} else {
  l
}
}

#' @keywords internal
add_number_names <- function(l){
  if(length(l)>1 && is.null(names(l))){
    names(l) <- seq_len(length(l))
  }
  l
}


#' Number Starting at \code{1}
#'
#' JavaScript starts at \code{0}, but R starts at \code{1}.
#' This means unnamed lists and vectors are indexed starting at
#' \code{0} in listviewer widgets.  This little helper function
#' tries to resolve the disconnect by assigning sequential numbers
#' starting at \code{1} to names for unnamed \code{lists} and \code{vectors}.
#' Please note though that using \code{number_unnamed} will potentially
#' cause difficulties serializing back and forth between JavaScript and R.
#'
#' @param l \code{list}
#'
#' @examples
#' library(listviewer)
#' jsonedit(
#'   number_unnamed(list(x=list(letters[1:3])))
#' )
#'
#' @export

number_unnamed <- function(l) {
  recurse(l, add_number_names)
}
