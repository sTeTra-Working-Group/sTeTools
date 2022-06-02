#' Reading Avian Hand-wing Index Data
#'
#' @description Reading, after downloading if needed, the avian hand-wing index in
#'  the data repository:
#'  Catherine Sheard. (2020). catherinesheard/Global-HWI v1.1 (v1.1). Zenodo. https://doi.org/10.5281/zenodo.3832215
#'
#' The associated article is: Sheard, C., Neate-Clegg, M.H.C., Alioravainen, N. et al. Ecological drivers of global gradients in avian dispersal inferred from wing morphology. Nat Commun 11, 2463 (2020). https://doi.org/10.1038/s41467-020-16313-6
#'
#'
#' @return a \code{data.frame} containing all variables from avian_ssd_jan07.txt
#' @export
#'

reading_avian_hwi <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded_data/traits/avian_hwi/catherinesheard-Global-HWI-1533081/Dataset HWI 2020-04-10.xlsx')) {
      download.file(url = 'https://zenodo.org/record/3832215/files/catherinesheard/Global-HWI-v1.1.zip?download=1', destfile = './data/cache/traits/avian_hwi.zip', mode = 'wb')
      unzip(zipfile = './data/cache/traits/avian_hwi.zip',
            exdir = './data/downloaded_data/traits/avian_hwi')
      file.remove('./data/cache/traits/avian_hwi.zip')
   }
   # read the Excel xlsx
   return(
      readxl::read_excel('./data/downloaded_data/traits/avian_hwi/catherinesheard-Global-HWI-1533081/Dataset HWI 2020-04-10.xlsx', sheet = 1, na = 'NA')
   )
}
