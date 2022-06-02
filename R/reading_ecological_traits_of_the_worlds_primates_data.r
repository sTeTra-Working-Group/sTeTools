#' Reading the Ecological traits of the world’s primates database
#'
#' @description Reading, after downloading if needed, the Ecological traits of
#' the world’s primates. The data is stored in a Zenodo repository (reference:
#' Galán-Acedo, Carmen, Arroyo-Rodríguez, Víctor, Andresen, Ellen, &
#' Arasa-Gisbert, Ricard. (2020). Ecological traits of the world's primates
#' database (Version 5) [Data set]. Zenodo. http://doi.org/10.5281/zenodo.3839032
#' The associated article is: Galán-Acedo, C., Arroyo-Rodríguez, V., Andresen, E.
#' et al. Ecological traits of the world’s primates. Sci Data 6, 55 (2019).
#' https://doi.org/10.1038/s41597-019-0059-9
#'
#' @return a \code{data.table} containing only body mass from the BodyMass_.csv table.
#' @export
#'

reading_ecological_traits_of_the_worlds_primates_data <- function() {
   create_folders()
   if (!file.exists('./downloaded data/traits/ecological_traits_of_the_worlds_primates_BodyMass_.csv')) {
      download.file(
         url = "https://zenodo.org/record/3839032/files/BodyMass_.csv?download=1",
         destfile = './downloaded data/traits/ecological_traits_of_the_worlds_primates_BodyMass_.csv', mode = 'w')
   }
   return(
      data.table::fread("./downloaded data/traits/ecological_traits_of_the_worlds_primates_BodyMass_.csv")
   )
}
