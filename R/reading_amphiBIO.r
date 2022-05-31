#' Reading the amphiBIO data
#'
#' @description Reading, after downloading if needed, the amphiBIO trait data
#' base from the FigShare repository (10.6084/m9.figshare.4644424.v5)
#' The complete archive is downloaded and stored, included metadata, references
#'  and traits. Reference: Oliveira, Brunno Freire; Sao-Pedro, Vinicius Avelar;
#'  Santos-Barrera, Georgina; Penone, Caterina; C. Costa, Gabriel (2017):
#'  AmphiBIO_v1. figshare. Dataset. https://doi.org/10.6084/m9.figshare.4644424.v5
#' The associated article is: Oliveira, B. F. et al. AmphiBIO, a global database
#'  for amphibian ecological traits. Sci. Data. 4:170123 doi:
#'  https://doi.org/10.1038/sdata.2017.123 (2017).
#'
#' @details
#'    Taxonomy follows Amphibian Species of the World species scientific names (Frost 2011).
#'
#' |  Variable name| Definition | Unit|
#' | --- | --- | --- |
#' |  Body_mass_g | Maximum adult body mass. | Grams |
#' |  Body_size_mm | Maximum adult body size. In Anura, body size is reported as snout to vent length (SVL). In Gymnophiona and Caudata, body size is reported as total length (TL). | Millimeter |
#' |  Size_at_mature_min_mm  | Minimum size at maturation/sexual maturity.  | Millimeter |
#' |  Size_at_mature_max_mm  | Maximum size at maturation/sexual maturity.  | Millimeter |
#'
#' @return a `data.table` containing only the body mass and size traits from
#'     the csv table AmphiBIO_v1.csv
#' @export
#' @md
#'


reading_amphiBIO <- function() {
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./downloaded data/traits/amphiBIO/AmphiBIO_v1.csv')) {
      download.file(url = 'https://ndownloader.figshare.com/files/8828578', destfile = './cache/traits/amphiBIO.zip', mode = 'wb')
      unzip(zipfile = './cache/traits/amphiBIO.zip',
            exdir = './downloaded data/traits/amphiBIO')
      file.remove('./cache/traits/amphiBIO.zip')
   }
   # reading the csv
   return(data.table::fread('./downloaded data/traits/amphiBIO/AmphiBIO_v1.csv', sep = ',', dec = '.', header = TRUE, encoding = 'Latin-1', select = c(1:5, 23, 26:28)))
}
