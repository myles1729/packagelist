% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/packagelist.R
\docType{package}
\name{packagelist}
\alias{packagelist}
\alias{packagelist-package}
\title{packagelist}
\description{
A package for saving and syncing lists of packages between systems
}
\details{
The \emph{packagelist} function allows the saving of a list of all currently installed packages (excluding base packages) with \emph{savepackages} and a function \emph{syncpackages} to install all of those packages from a saved list.
There are also functions to return the current Dropbox directory, to count the number of packages "out of sync" and to list these packages.
By default, all lists are saved as RDS files in the current working directory, but a different directory can be passed as an argument.
}
