#' Reading rate of living in tetrapods data set
#'
#' @description Reading, after downloading if needed, the data in the
#' supplementary material associated to the article  Stark, G, Pincheira-Donoso, D,
#'  Meiri, S. No evidence for the "rate-of-living" theory across the tetrapod
#'  tree of life. Global Ecol Biogeogr. 2020; 29: 857-884.
#'  https://doi.org/10.1111/geb.13069
#'
#' @return A \code{data.table} containing biomass values aggregated from the
#'  literature by Stark et al for 4100 land vertebrates species.
#' @export
#'

reading_rate_of_living_in_tetrapods_data <- function() {
   create_folders()
   if (!file.exists( './data/downloaded data/traits/rate_of_living_in_tetrapods.csv')) {
      download.file(
         url = "https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fgeb.13069&file=geb13069-sup-0001-AppendixS1.xlsx",
         destfile = './data/cache//traits/rate-of-living_geb13069-sup-0001-AppendixS1.xlsx',
         mode = 'wb')

      rol <- data.table::as.data.table(
         readxl::read_xlsx('./data/cache//traits/rate-of-living_geb13069-sup-0001-AppendixS1.xlsx', sheet = 1, n_max = 4100)
      )
      data.table::set(x = rol, j = c(5L, 8L:14L), value = NULL) # deleting unwanted columns
      data.table::fwrite(x = rol, file = './data/downloaded data/traits/rate_of_living_in_tetrapods.csv', dec = '.', sep = ',')

      file.remove('./data/cache//traits/rate-of-living_geb13069-sup-0001-AppendixS1.xlsx')
      return(rol)
   } else {
      return(
         data.table::fread(file = './data/downloaded data/traits/rate_of_living_in_tetrapods.csv',
                           dec = '.', sep = ',', header = TRUE)
      )
   }
}
