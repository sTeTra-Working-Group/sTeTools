#' Reading Cooke trait data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Cooke, Robert (2018): Global trade-offs of functional redundancy and functional
#' dispersion for birds and mammals. figshare. Dataset.
#' https://doi.org/10.6084/m9.figshare.5616424.v1
#'
#' @details
#' Associated paper: Cooke et al., 2019 - Global trade-offs of functional
#' redundancy and functional dispersion for birds and mammals. Global Ecology and
#' Biogeography https://onlinelibrary.wiley.com/doi/pdf/10.1111/geb.12869
#' Six traits are here made available for all 15,485 terrestrial extant bird and
#' mammal species: body mass, litter/clutch size, diel activity, diet, volancy
#' and habitat breadth
#' The trait data were compiled from four main sources: PanTHERIA (Jones et al., 2009),
#' Pacifici database (Pacifici et al., 2013), EltonTraits database (Wilman et al., 2014)
#' and Amniote database (Myhrvold et al., 2015), which should be cited, alongwith
#' this paper, when using this trait data.
#'
#' @return A \code{data.table}, of traits for mammals and birds
#' @export
#'

reading_cooke <- function() {
   # downloading from figshare, unzipping, deleting the archive.
   return(
      data.table::fread(
         file = suppdata::suppdata(
            x = "https://doi.org/10.6084/m9.figshare.5616424.v1",
            si = 4, from = "figshare",
            dir = "./data/downloaded_data/traits", save.name = "cooke_2018_trait_data.csv"
         ), sep = ",", header = TRUE
      )
   )
}
