#' Reading globTHERM data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Bennett, Joanne M. et al. (2019), Data from: GlobTherm, a global database on
#' thermal tolerances for aquatic and terrestrial organisms, Dryad, Dataset,
#' https://doi.org/10.5061/dryad.1cv08
#' associated to the article:
#' GlobTherm, a global database on thermal tolerances for aquatic and terrestrial
#' organisms, CSV format
#' This database includes thermal tolerance metrics for 2,133 species of multicellular
#' algae, plants, fungi, and animals in 43 classes, 203 orders and 525 families from
#' both aquatic, and terrestrial realms, extracted from published studies. Abbreviated
#' citations are included in the 'REF_min' and 'REF_max' variable in the data file.
#' For full citations, please see the attached workbook, "References_1_09_2017.xlsx".
#' @return A \code{data.table}, for  algae, plants, fungi, and animals
#' @export
#'

reading_globTHERM <- function() {
   return(
      data.table::fread(
         file = rdryad::dryad_download(dois = "10.5061/dryad.1cv08")[[1]][[1]],
         sep = ",", header = TRUE)
   )
}
