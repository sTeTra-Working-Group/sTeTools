#' Reading the Elton Traits data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Wilman, Hamish; Belmaker, Jonathan; Simpson, Jennifer; de la Rosa, Carolina;
#'  Rivadeneira, Marcelo M.; Jetz, Walter (2016): EltonTraits 1.0: Species-level
#'  foraging attributes of the world's birds and mammals. Wiley. Collection.
#'  https://doi.org/10.6084/m9.figshare.c.3306933.v1
#' The associated article is Wilman, H., Belmaker, J., Simpson, J., de la Rosa,
#'  C., Rivadeneira, M.M. and Jetz, W. (2014), EltonTraits 1.0: Species-level
#'  foraging attributes of the world's birds and mammals. Ecology, 95: 2027-2027.
#'  https://doi.org/10.1890/13-1917.1
#' @return A list of 2 \code{data.tables}, for mammals and birds
#' @export
#'


reading_elton_traits <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded_data/traits/elton_traits_1.0/MamFuncDat.txt')) {
      download.file(url = 'https://ndownloader.figshare.com/articles/3559887/versions/1', destfile = './data/cache//traits/elton_traits_1.0.zip', mode = 'wb')
      unzip(zipfile = './data/cache//traits/elton_traits_1.0.zip',
            exdir = './data/downloaded_data/traits/elton_traits_1.0')
      file.remove('./data/cache//traits/elton_traits_1.0.zip')
   }

   # reading the csv
   return(
      list(
         mammals = data.table::fread('./data/downloaded_data/traits/elton_traits_1.0/MamFuncDat.txt', sep = '\t', dec = '.', header = TRUE, nrows = 5400, drop = 4:23, na.strings = ''),
         birds = data.table::fread('./data/downloaded_data/traits/elton_traits_1.0/BirdFuncDat.txt', sep = '\t', dec = '.', header = TRUE, nrows = 9993, drop = 9:35, na.strings = '')
      )
   )

}
