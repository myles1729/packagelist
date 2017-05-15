#' Count number of packages out of sync
#'
#' Counts the number of packages out of sync between two list of packages saved
#' with \emph{savepackages} in your working directory
#'
#' @param workdir (optional): an alternative path to the package list files
#' @return Number of packages out of sync
#' @export
countpackdiff <- function(workdir = getwd()) {
  setwd(workdir)
  ip.windows <- readRDS("windowspackagelist.rds")
  ip.mac <- readRDS("macpackagelist.rds")
  ipdiff.mac <- setdiff(ip.windows,ip.mac)
  ipdiff.windows <- setdiff(ip.mac,ip.windows)
  if(Sys.info()['sysname']=="Windows") {
    return(length(ipdiff.windows))
  } else if(Sys.info()['sysname']=="Darwin") {
    return(length(ipdiff.mac))
  } else {
    stop("Error syncing packagelist: Sysname is not Windows or Darwin")
  }
}
