#' Reading the amniote life history trait data
#'
#' @description Reading, after downloading if needed, the Amniote life history trait data
#' base from the FigShare repository (https://doi.org/10.6084/m9.figshare.c.3308127.v1)
#' The complete archive is downloaded and stored, included meta data, figures,
#' references and supplementaries.
#'
#' @return a \code{data.table} containing the content of the csv table
#' Amniote_Sparse_Table_Aug_2015.csv.
#' @export
#'
#'

reading_amniote_life_history_trait_database <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./downloaded data/traits/amniote_life_history_database/Data_Files/Amniote_Sparse_Table_Aug_2015.csv')) {
      download.file(url = 'https://ndownloader.figshare.com/files/8067269', destfile = './cache/traits/amniote_life_history_database.zip', mode = 'wb')
      unzip(zipfile = './cache/traits/amniote_life_history_database.zip',
            exdir = './downloaded data/traits/amniote_life_history_database')
      file.remove('./cache/traits/amniote_life_history_database.zip')
   }
   # reading the csv
   return(data.table::fread('./downloaded data/traits/amniote_life_history_database/Data_Files/Amniote_Sparse_Table_Aug_2015.csv', na.strings = '-999', sep = ',', dec = '.', header = TRUE))
}
