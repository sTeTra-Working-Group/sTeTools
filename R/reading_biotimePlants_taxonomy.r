#' Reading bioTIME PLANT section with taxonomy columns only.
#'
#' @return A \code{data.table} containing the list of plant species in BioTIME and
#' internally shared on the Google Drive. Taxa identified at the species level
#' only.
#' @export
#'

reading_biotimePlants_taxonomy <- function() {
   return(data.table::fread('./shared data/biotimePlants.csv', sep = ',', header = TRUE))
}
