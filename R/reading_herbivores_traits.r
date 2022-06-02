#' Reading the functional trait data for late Quaternary herbivorous birds and mammals
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Lundgren, Erick J; Schowanek, Simon D; Rowan, John; Middleton, Owen; Pedersen,
#'  Rasmus O; Wallach, Arian D; et al. (2021): Functional traits of the world's
#'  late Quaternary large-bodied avian and mammalian herbivores. figshare.
#'  Collection. https://doi.org/10.6084/m9.figshare.c.5001971.v1
#' The associated article is Lundgren, E.J., Schowanek, S.D., Rowan, J. et al.
#' Functional traits of the world's late Quaternary large-bodied avian and
#' mammalian herbivores. Sci Data 8, 17 (2021).
#' https://doi.org/10.1038/s41597-020-00788-5
#' @return A \code{data.table} with body mass data for numerous herbivorous species
#'   aggregated from the literature.
#' @export
#'

reading_herbivores_traits <- function() {
   create_folders()
   if (!file.exists('./data/downloaded data/traits/european_amphibians_database3.csv')) {
      download.file(
         url = "https://springernature.figshare.com/ndownloader/files/25606121",
         destfile = './data/cache//traits/quaternary_herbivores.xlsx', mode = 'wb')

      qh <- data.table::as.data.table(
         readxl::read_xlsx('./data/cache//traits/quaternary_herbivores.xlsx', sheet = 2)
      )[, 1:12]

      data.table::fwrite(x = qh,
                         file = './data/downloaded data/traits/quaternary_herbivores.csv',
                         dec = '.', sep = ','
      )
      file.remove('./data/cache//traits/quaternary_herbivores.xlsx')

      return(qh)
   } else {
      return(
         data.table::fread(file = './data/downloaded data/traits/quaternary_herbivores.csv',
                           dec = '.', sep = ',', header = TRUE)
      )
   }
}
