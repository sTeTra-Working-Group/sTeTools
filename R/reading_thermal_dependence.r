#' Reading the thermal dependence of biological traits data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Dell, Anthony, I.; Pawar, Samraat; M. Savage, Van (2016): Data Paper. Data
#'  Paper. Wiley. Dataset. https://doi.org/10.6084/m9.figshare.3556611.v1
#' The associated article is: Dell, A.I., Pawar, S. and Savage, V.M. (2013),
#'  The thermal dependence of biological traits. Ecology, 94: 1205-1206.
#'  https://doi.org/10.1890/12-2060.1
#' @return A \code{data.table} with all traits. This data set does not seem to provide
#'    raw body size or body mass values
#' @export
#'


reading_thermal_dependence <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded_data/traits/elton_traits_1.0/MamFuncDat.txt')) {
      download.file(
         url = 'https://ndownloader.figshare.com/articles/3556611/versions/1',
         destfile = './data/cache//traits/thermal_dependence.zip',
         mode = 'wb')
      unzip(zipfile = './data/cache//traits/thermal_dependence.zip',
            exdir = './data/downloaded_data/traits/thermal_dependence')
      file.remove('./data/cache//traits/thermal_dependence.zip')
   }

   # reading the csv
   return(
      data.table::as.data.table(
         read.csv(
            text = paste0(
               stringi::stri_read_lines(
                  './data/downloaded_data/traits/thermal_dependence/TempTrait_001.txt',
                  encoding = 'UTF-16LE'),
               collapse = "\n"),
            sep = "\t",
            stringsAsFactors = FALSE)
      )
   )
}
