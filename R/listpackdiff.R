#' Count number of packages out of sync
#'
#' Lists the packages out of sync between two list of packages saved with \emph{savepackages} in your working directory
#'
#' @param workdir (optional): an alternative path to the package list files
#' @return List of packages out of sync
#' @export

listpackdiff <- function(workdir = getwd()) {
  setwd(workdir)
  ip.windows <- readRDS("windowspackagelist.rds")
  ip.mac <- readRDS("macpackagelist.rds")
  ipdiff.mac <- setdiff(ip.windows,ip.mac)
  ipdiff.windows <- setdiff(ip.mac,ip.windows)
  if(Sys.info()['sysname']=="Windows") {
    return((ipdiff.windows))
  } else if(Sys.info()['sysname']=="Darwin") {
    return((ipdiff.mac))
  } else {
    stop("Error syncing packagelist: Sysname is not Windows or Darwin")
  }
}
