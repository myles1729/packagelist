#' Returns the Dropbox directory
#'
#' Finds the current Dropbox directory on your system and returns it as a file-path
#'
#' @param None
#'
#' @return A filepath string
#' @note This is just using the paths described in the Dropbox documentation, after determining the system name to be one of "Windows", "Darwin" or "Linux"
#' @references \url{https://www.dropbox.com/help/desktop-web/find-folder-paths}
#' @export

getdropboxdir <- function() {

  # Set the working directory to the Dropbox Research R folder
  OSlist <- list("Darwin","Linux")

  if(Sys.info()['sysname']=="Windows") {
    if(file.path(Sys.getenv("APPDATA"),"Dropbox/info.json")) {
      windowspathtojson <- file.path(Sys.getenv("APPDATA"),"Dropbox/info.json")
    } else {
      windowspathtojson <- file.path(Sys.getenv("LOCALAPPDATA"),"Dropbox/info.json")
    }
    jsonlite::fromJSON(readLines(windowspathtojson))->json
    json$personal$path -> pathtodropbox
  } else if(Sys.info()['sysname'] %in% OSlist) {
    jsonlite::fromJSON(readLines("~/.dropbox/info.json"))->json
    json$personal$path -> pathtodropbox
  } else {
    stop("Error: Sysname is not Windows or Darwin")
  }
  return(file.path(pathtodropbox))
}

