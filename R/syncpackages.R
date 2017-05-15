#' Save package list
#'
#' Installs all packages from a list saved with \emph{savepackages} in your working directory
#'
#' @param workdir (optional): an alternative path to the package list file
#' @return none
#' @export

syncpackages <- function(workdir = getwd()) {
  setwd(workdir)
  if(Sys.info()['sysname']=="Windows") {
    savewindowspackagelist()
    updatewindowspackages()
  } else if(Sys.info()['sysname']=="Darwin") {
    savemacpackagelist()
    updatemacpackages()
  } else {
    stop("Error syncing packagelist: Sysname is not Windows or Darwin")
  }
}
