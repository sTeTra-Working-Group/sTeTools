#' Reading bioTIME fish section with taxonomy columns only.
#'
#' @return A \code{data.table} containing the list of fish species in BioTIME and
#' internally shared on the Google Drive. Taxa identified at the species level
#' only.
#' @export
#'

reading_biotimeFish_taxonomy <- function() {
   return(data.table::fread('./shared data/biotimeFish.csv', sep = ',', header = TRUE))
}
