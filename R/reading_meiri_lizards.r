
#' Reading Meiri 2018 lizard traits
#'
#' @description Reading, after downloading if needed, the trait data from:
#' SMeiri, Shai (2019), Data from: Traits of lizards of the world: variation
#' around a successful evolutionary design, Dryad, Dataset,
#' https://doi.org/10.5061/dryad.f6t39kj
#' @return A \code{data.table}, for lizards
#' @export
#'

reading_meiri_lizards <- function() {
   # rdryad::dryad_download(dois = "10.5061/dryad.f6t39kj")
   # suppdata::suppdata(x = "10.5061/dryad.f6t39kj", si = "doi_10.5061_dryad.f6t39kj__v1.zip")
   create_folders()
   if (!file.exists("./data/downloaded_data/meiri_lizards_Appendix S1 - Lizard data version 1.0.csv"))   download.file(
      url = "https://datadryad.org/stash/downloads/file_stream/77989",
      destfile = "./data/downloaded_data/meiri_lizards_Appendix S1 - Lizard data version 1.0.csv"
   )

   return(
      data.table::fread(
         file = "./data/downloaded_data/meiri_lizards_Appendix S1 - Lizard data version 1.0.csv",
         sep = ",", header = TRUE
      )
   )
}
