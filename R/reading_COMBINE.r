#' Reading COMBINE raw data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Soria, C.D., Pacifici, M., Di Marco, M., Stephen, S.M. and Rondinini, C.
#' (2021), COMBINE: a coalesced mammal database of intrinsic and extrinsic
#' traits. Ecology. Accepted Author Manuscript e03344.
#' https://doi.org/10.1002/ecy.3344
#' @return A \code{data.table}, for mammals
#' @export
#'


reading_COMBINE_raw <- function() {
   create_folders()
   return(
      data.table::fread(
         file = suppdata::suppdata(
            x = '10.6084/m9.figshare.13028255.v4', si = 18, from = 'figshare',
            dir = './data/downloaded_data/traits', save.name = 'COMBINE_trait_data_reported.csv'),
         sep = ',', dec = '.', header = TRUE
         )
   )
}

#' Reading COMBINE imputed data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Soria, C.D., Pacifici, M., Di Marco, M., Stephen, S.M. and Rondinini, C.
#' (2021), COMBINE: a coalesced mammal database of intrinsic and extrinsic
#' traits. Ecology. Accepted Author Manuscript e03344.
#' https://doi.org/10.1002/ecy.3344
#' @return A \code{data.table}, for mammals
#' @export
#'


reading_COMBINE_imputed <- function() {
   create_folders()
   return(
      data.table::fread(
         file = suppdata::suppdata(
            x = '10.6084/m9.figshare.13028255.v4', si = 19, from = 'figshare',
            dir = './data/downloaded_data/traits', save.name = 'COMBINE_trait_data_imputed.csv'),
         sep = ',', dec = '.', header = TRUE
      )
   )
}
