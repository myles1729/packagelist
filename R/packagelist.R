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
