#' Reading length mass allometries in amphibians data set
#'
#' @description Reading, after downloading if needed, the length mass allometries
#'  in amphibians data set. The data is available as a supplementary file with
#'  SANTINI, L., BENITEZ‐LOPEZ, A., FICETOLA, G.F. and HUIJBREGTS, M.A.J. (2018),
#'  Length-mass allometries in amphibians. Integrative Zoology, 13: 36-45.
#'  https://doi.org/10.1111/1749-4877.12268
#'
#' @return A \code{data.table} containing biomass and SVL values aggregated from the
#'  literature by Santini et al.
#' @export
#'

reading_length_mass_allometries_in_amphibians_data <- function() {
   create_folders()
   if (!file.exists( './data/downloaded data/traits/Length–mass_allometries_in_amphibians.csv')) {
      download.file(
         url = "https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2F1749-4877.12268&file=inz212268-sup-0002-S1.xls",
         destfile = './cache/traits/amphibian_allometries_inz212268-sup-0002-S1.xls',
         mode = 'wb')

      lma <- data.table::as.data.table(
         readxl::read_xls('./cache/traits/amphibian_allometries_inz212268-sup-0002-S1.xls', sheet = 1)
      )
      data.table::fwrite(x = lma, file = './data/downloaded data/traits/Length–mass_allometries_in_amphibians.csv', dec = '.', sep = ',')

      file.remove('./cache/traits/amphibian_allometries_inz212268-sup-0002-S1.xls')

      return(lma)
   } else {
      return(
         data.table::fread(file = './data/downloaded data/traits/Length–mass_allometries_in_amphibians.csv',
                           dec = '.', sep = ',', header = TRUE)
      )
   }
}
