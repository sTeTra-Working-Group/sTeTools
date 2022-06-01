#' Reading UHURU experimental site measure and occurrence data for mammals
#'
#' @description Reading, after downloading if needed, the trait measurements and
#' occurrence data from:
#' Alston, Jesse M.,Courtney G. Reed, Leo M. Khasoha, Bianca R.P. Brown, Gilbert
#' Busienei, Nathaniel Carlson, Tyler C. Coverdale, et al. 2022. “Ecological Consequences
#' of Large Herbivore Exclusion in an African Savanna: 12 years of Data from the UHURU
#' Experiment.” Ecology 103(4): e3649
#'
#' @details
#' Associated paper:
#'
#' @return A \code{data.table}, of traits for mammals
#' @export
#'

reading_UHURU_measures <- function() {
   # downloading from Dryad with rDryad

   ddata <- data.table::fread(file = rdryad::dryad_download("10.5061/dryad.1g1jwstxw")[[1L]][7L])

   coords <- data.table::fread(file = rdryad::dryad_download("10.5061/dryad.1g1jwstxw")[[1L]][4L],
                               drop = 3L:4L)
   mean_coords <- coords[, .(dd_long = mean(dd_long), dd_lat = mean(dd_lat)), by = .(site, block)][, site := c("S","C","N")[match(site, c("SOUTH","CENTRAL","NORTH"))]]

   return(
      ddata[mean_coords, on = c("site","block")]
   )
}
