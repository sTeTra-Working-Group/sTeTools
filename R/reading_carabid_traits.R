#' Reading carabid traits
#'
#' @return A \code{data.table} containing traits for 10 335 carabid species.
#' @export
#'

reading_carabid_traits <- function() {
   create_folders()
   dir.create('./shared_data/carabids/', showWarnings = FALSE)
   caratraits <- unique(
      data.table::rbindlist(
         lapply(list.files('./shared_data/carabids/', full.names = TRUE),
                FUN = data.table::fread, sep = ';', header = TRUE, na.string = '',
                encoding = 'UTF-8', stringsAsFactors = FALSE
         )
      )
   )
   data.table::set(x = caratraits, j = "distributionArea", value = as.integer(gsub(',', '', caratraits$distributionArea)))
   return(caratraits)
}
