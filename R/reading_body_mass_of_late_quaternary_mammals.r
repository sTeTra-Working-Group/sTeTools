#' Reading the MOM data set.
#'
#' @description Reading, after downloading if needed, the data set: A. Smith,
#' Felisa; Kathleen Lyons, S.; Ernest, S. K. Morgan; E. Jones, Kate; Kaufman,
#' Dawn M.; Dayan, Tamar; et al. (2016): BODY MASS OF LATE QUATERNARY MAMMALS.
#' Wiley. Collection. https://doi.org/10.6084/m9.figshare.c.3297995.v1.
#' This data set is associated with the article: Smith, F.A., Lyons, S.K., Ernest,
#' S.K.M., Jones, K.E., Kaufman, D.M., Dayan, T., Marquet, P.A., Brown, J.H. and
#'  Haskell, J.P. (2003), BODY MASS OF LATE QUATERNARY MAMMALS. Ecology,
#'  84: 3403-3403. https://doi.org/10.1890/02-9003
#'
#' | Variable name | Variable definition |
#' | --- | --- |
#' | Continent | Continent that a species resides on. If species resides on more than one continent, a continent specific body mass is reported when available.  Thus, some mammals have multiple entries. The division between North and South America occurs at the isthmus of Panama. |
#' | Status | Whether species is currently present in the wild (extant); extinct as of late Pleistocene (extinct), extinct within the last 300 years (historical); or an introduction (introduction); Note these do not necessarily follow CITES or IUCN categories. |
#' | Order  | Taxonomic order of species |
#' | Family | Taxonomic family of species |
#' | Genus | Taxonomic genus of species |
#' | Species | species epithet |
#' | log mass | Log10 transformation of Combined Mass  |
#' | combined mass | Adult body mass averaged across males and females and geographic locations. |
#' | reference | Reference source for body mass information and/or status for that species; the updated electronic version of Wilson and Reeder (1993)  (6 June 2002; www.nmnh.si.edu/msw) serves as the status reference for all extant species. |
#'
#' The list of references is provided in the metadata file metadata.htm.
#'
#' @return a `data.table` containing MOMv3.txt content.
#' @export
#' @md
#'


reading_body_mass_of_late_quaternary_mammals <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded data/traits/99_bird_species_data-02-00012-s001/Table 1.csv')) {
      download.file(url = 'https://ndownloader.figshare.com/articles/3523112/versions/1', destfile = './data/cache/traits/body_mass_of_late_quaternary_mammals.zip', mode = 'wb')
      unzip(zipfile = './data/cache/traits/body_mass_of_late_quaternary_mammals.zip',
            exdir = './data/downloaded data/traits/body_mass_of_late_quaternary_mammals')
      file.remove('./data/cache/traits/body_mass_of_late_quaternary_mammals.zip')
   }

   # reading the csv
   mom <- data.table::fread('./data/downloaded data/traits/body_mass_of_late_quaternary_mammals/MOMv3.3.txt', sep = '\t', dec = '.', header = FALSE, na.strings = '-999')
   data.table::setnames(mom, c('continent','status','order','family','genus','species','log mass','combined mass','reference'))
   return(mom)
}
