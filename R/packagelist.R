#' packagelist
#'
#' @description
#' A package for saving and syncing lists of packages between systems
#'
#' @details
#' The \emph{packagelist} function allows the saving of a list of all currently installed packages (excluding base packages) with \emph{savepackages} and a function \emph{syncpackages} to install all of those packages from a saved list.
#' There are also functions to return the current Dropbox directory, to count the number of packages "out of sync" and to list these packages.
#' By default, all lists are saved as RDS files in the current working directory, but a different directory can be passed as an argument.
#'
#' @docType package
#' @name packagelist

options(stringsAsFactors = FALSE)


savewindowspackagelist <- function()
{
  ip <- as.data.frame(utils::installed.packages()[,c(1,3:4)])
  rownames(ip) <- NULL
  ip<-ip[is.na(ip$Priority),1:2,drop=FALSE]
  ip<-ip[,1]
  saveRDS(ip,"windowspackagelist.rds")
}

savemacpackagelist <- function()
{
  ip <- as.data.frame(utils::installed.packages()[,c(1,3:4)])
  rownames(ip) <- NULL
  ip<-ip[is.na(ip$Priority),1:2,drop=FALSE]
  ip<-ip[,1]
  saveRDS(ip,"macpackagelist.rds")
}

updatewindowspackages <- function()
{
  ip.windows <- readRDS("windowspackagelist.rds")
  ip.mac <- readRDS("macpackagelist.rds")
  ip <- setdiff(ip.mac,ip.windows)
  if(length(ip)==0) {
    cat("No packages to update")
  } else {
    utils::install.packages(ip,repos = c(CRAN = "http://cran.rstudio.com"))
    cat(paste("Updated",length(ip),"packages"))
  }
}

updatemacpackages <- function()
{
  ip.windows <- readRDS("windowspackagelist.rds")
  ip.mac <- readRDS("macpackagelist.rds")
  ip <- setdiff(ip.windows,ip.mac)
  if(length(ip)==0) {
    cat("No packages to update")
  } else {
    utils::install.packages(ip,repos = c(CRAN = "http://cran.rstudio.com"))
    cat(paste("Updated",length(ip),"packages"))
  }
}
