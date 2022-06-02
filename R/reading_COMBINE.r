#' Reading COMBINE data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Soria, C.D., Pacifici, M., Di Marco, M., Stephen, S.M. and Rondinini, C.
#' (2021), COMBINE: a coalesced mammal database of intrinsic and extrinsic
#' traits. Ecology. Accepted Author Manuscript e03344.
#' https://doi.org/10.1002/ecy.3344
#' @return A \code{data.table}, for mammals
#' @export
#'


reading_COMBINE <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1/MetadataS1.pdf')) {
      suppdata::suppdata(x = '10.1002/ecy.3344', si = 1, from = 'wiley',
                         dir = './data/cache/traits', save.name = 'COMBINE_10.1002_ecy.3344_1.zip')
      unzip(zipfile = './data/cache/traits/COMBINE_10.1002_ecy.3344_1.zip',
            exdir = './data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1')

      unzip(zipfile = './data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1/ecy3344-sup-0001-datas1.zip',
            exdir = './data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1')
      file.remove('./data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1/ecy3344-sup-0001-datas1.zip')
   }

   # reading the csv
   return(
      data.table::fread('./data/downloaded data/traits/COMBINE_10.1002_ecy.3344_1/COMBINE_archives/trait_data_imputed.csv', sep = ',', dec = '.', header = TRUE)
   )
}
