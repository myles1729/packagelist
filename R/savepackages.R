#' Save package list
#'
#' Saves all currently installed packages to an RDS file in your working directory
#'
#' @param workdir (optional): an alternative path to save to
#' @return none
#' @export

savepackages <- function(workdir = getwd()) {
  setwd(workdir)
  if(Sys.info()['sysname']=="Windows") {
    savewindowspackagelist()
  } else if(Sys.info()['sysname']=="Darwin") {
    savemacpackagelist()
  } else {
    stop("Error syncing packagelist: Sysname is not Windows or Darwin")
  }
}
