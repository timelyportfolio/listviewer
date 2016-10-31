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
}

