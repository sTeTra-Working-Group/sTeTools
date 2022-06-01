#' Reading PORTAL experimental site measure and occurrence data for mammals
#'
#' @description Reading, after downloading if needed, the trait measurements and
#' occurrence data from:
#' S. K. Morgan Ernest, Glenda M. Yenni, Ginger Allington, Ellen K. Bledsoe,
#' Erica M. Christensen, Renata Diaz, Keith Geluso, Jacob R. Goheen, Qinfeng Guo,
#' Edward Heske, Douglas Kelt, Joan M. Meiners, Jim Munger, Carla Restrepo,
#' Douglas A. Samson, Michele R. Schutzenhofer, Marian Skupski, Sarah R. Supp,
#' Katherine M. Thibault, … Thomas J. Valone. (2022). weecology/PortalData: 3.88.0
#' (3.88.0) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.6595703
#'
#'
#' @return A \code{data.table}, of weights for mammals
#' @export
#'

reading_PORTAL_weights <- function() {
   # downloading with dedicated portalr package

   if (portalr::check_for_newer_data()) portalr::download_observations()

   return(
      data.table::fread(file = paste0(portalr::get_default_data_path(), "/PortalData/Rodents/Portal_rodent.csv"))[!is.na(wgt)]
   )
}
