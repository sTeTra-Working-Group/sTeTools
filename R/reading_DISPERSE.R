#' Reading DISPERSE data
#'
#' @description Reading, after downloading if needed, the trait data from:
#' Sarremejane, Romain; Cid, Núria; Stubbington, Rachel; Datry, Thibault;
#' Alp, Maria; Cañedo-Argüelles, Miguel; et al. (2020): DISPERSE – A trait
#' database to assess the dispersal potential of aquatic macroinvertebrates.
#' figshare. Collection. https://doi.org/10.6084/m9.figshare.c.5000633.v1
#' @return A \code{data.table}, for aquatic invertebrates
#' @export
#'


reading_DISPERSE <- function() {
   create_folders()
   # downloading from figshare

   if (!file.exists("./data/downloaded_data/traits/R_Disperse.csv")) {
      try(
         suppdata::suppdata(
            x = "10.6084/m9.figshare.c.5000633.v3",
            si = 1, from = "figshare",
            dir = "./data/cache/traits", save.name = "R_Disperse.xlsx"),
         silent = TRUE)
      if (!file.exists("./data/cache/traits/R_Disperse.xlsx")) download.file(
         url = "https://springernature.figshare.com/ndownloader/files/24964343",
         destfile = "./data/cache/traits/R_Disperse.xlsx",
         mode = 'wb'
      )

      traits <- readxl::read_xlsx("./data/cache/traits/R_Disperse.xlsx", sheet = 1)
      values <- readxl::read_xlsx("./data/cache/traits/R_Disperse.xlsx", sheet = 2, skip = 2)

      colnames(values)[match(traits$Code, colnames(values))] <- traits$Trait[match( colnames(values)[match(traits$Code, colnames(values))], traits$Code)]

      write.table(x = values, file = "./data/downloaded_data/traits/R_Disperse.csv", sep = ",", dec = '.', row.names = FALSE, na = 'NA')
   }

   # reading the csv
   return(
      data.table::fread('./data/downloaded_data/traits/R_Disperse.csv', sep = ',', dec = '.', header = TRUE)
   )
}


