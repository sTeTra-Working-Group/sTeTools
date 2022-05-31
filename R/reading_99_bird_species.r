#' Reading the Ecological and Functional Traits in 99 Bird Species data
#'
#' @description Reading, after downloading if needed, the Ecological and
#'  Functional Traits in 99 Bird Species (reference: Renner, Swen C.; Hoesel,
#'  Willem van. 2017. "Ecological and Functional Traits in 99 Bird Species over
#'  a Large-Scale Gradient in Germany" Data 2, no. 2: 12. )
#' The complete archive is downloaded and stored. The authors provide 2 data sets:
#'     - measures they made on 28 species in 71 sites in 3 area in Germany
#'     (48.41 North, 9.41 East ; 51.15 North, 10.38 East ;
#'      52.98 North, 13.76 East)
#'     - measures compiled from the literature for 99 species
#'
#' @return a list of two \code{data.tables} corresponding to both datasets: measured and
#'     compiled for table 1 and 2 respectively. Users can merge them if preferred.
#' @export
#'


reading_99_bird_species <- function() {
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./downloaded data/traits/99_bird_species_data-02-00012-s001/Table 1.csv')) {
      download.file(url = 'https://www.mdpi.com/2306-5729/2/2/12/s1', destfile = './cache/traits/data-02-00012-s001.zip', mode = 'wb')
      unzip(zipfile = './cache/traits/data-02-00012-s001.zip',
            exdir = './downloaded data/traits/99_bird_species_data-02-00012-s001')
      file.remove('./cache/traits/data-02-00012-s001.zip')
   }

   # reading the csv
   return(
      list(
         measured = data.table::fread('./downloaded data/traits/99_bird_species_data-02-00012-s001/Table 1.csv', sep = ';', dec = '.', header = TRUE, na.strings = 'n/a'),
         compiled = data.table::fread('./downloaded data/traits/99_bird_species_data-02-00012-s001/Table 2.csv', sep = ';', dec = '.', header = TRUE, na.strings = 'n/a')
      )
   )

}
