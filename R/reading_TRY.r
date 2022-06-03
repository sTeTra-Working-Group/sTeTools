###### Reading local TRY imputed AND raw data

#' Reading local TRY imputed data
#' @description Reading TRY plant trait data from the local TRY archive.
#' Species names are extracted from the input_data/hierarchy.info.csv table.
#'
#' Trait codes are extracted from the
#' TRY metadata: ReadMe_TRYvs5_GapfilledData.docx.
#'
#' Trait values are extracted from gapfilled_data/mean_gap_filled.txt
#'
#' Back transformed data is also available in the archive.
#'
#' @param path Path to the folder where the archive is and where data will be extracted
#' default to ./data/shared_data/
#' @return A \code{data.table}, for plants
#' @export
#'

reading_TRY_imputed <- function(path = "./data/shared_data") {
   if (!file.exists(paste0(path, "/TRY_5_GapFilledData_2020.zip"))) stop("the archive TRY_5_GapFilledData_2020.zip has to be manually placed in your local project/data/shared_data")
   if (!file.exists(paste0(path, "/TRY_5_GapFilledData_2020/gapfilled_data/mean_gap_filled.txt"))) {
      unzip(
         zipfile = paste0(path, "/TRY_5_GapFilledData_2020.zip"),
         files = c(
            "TRY_5_GapFilledData_2020/gapfilled_data/mean_gap_filled.txt",
            "TRY_5_GapFilledData_2020/input_data/hierarchy.info.csv"),
         exdir = path, overwrite = TRUE
      )
   }

   ## loading data
   try_imputed <- data.table::fread(
      file = paste0(path, "/TRY_5_GapFilledData_2020/gapfilled_data/mean_gap_filled.txt"),
      sep = "\t", header = TRUE, quote = "'"
   )

   hierarchy <- data.table::fread(
      file = './data/shared_data/TRY_5_GapFilledData_2020/input_data/hierarchy.info.csv',
      sep = ",", header = TRUE, select = c("V1", "Species")
   )

   trait_codes <- data.table::fread(
      file = './data/shared_data/TRY_trait_codes.csv',
      sep = ",", header = TRUE, skip = 1
   )

   ## replacing trait names
   long_names <- trait_codes$`Trait Name`[match(
      gsub(pattern = '[^0-9]', replacement = '',x = colnames(try_imputed), perl = TRUE),
      as.character(trait_codes$TraitID))]
   if (anyNA(long_names)) warning("Missing trait code definition in trait table")

   new_trait_names <- data.table::fifelse(
      test = is.na(long_names),
      yes = gsub(pattern = '[^0-9]', replacement = '', x = colnames(try_imputed), perl = TRUE),
      no = long_names
   )

   data.table::setnames(try_imputed, new_trait_names)
   if (any(hierarchy$V1 != row.names(try_imputed))) stop ("hieararchy.info.csv and mean_gap_filled.txt do not match")
   return(
      try_imputed[, species := hierarchy$Species][]
   )
}





#' Reading local TRY RAW data
#' @description Reading local trait data from TRY.
#'
#' Species names are extracted
#' from the input_data/hierarchy.info.csv table.
#'
#' Trait codes are extracted from the
#' TRY metadata: ReadMe_TRYvs5_GapfilledData.docx.
#'
#' Trait values are extracted from input_data/traint.info.csv
#' @param path Path to the folder where the archive is and where data will be extracted
#' default to ./data/shared_data/
#'
#' @return A \code{data.table}, for plants
#' @export
#'

reading_TRY_raw <- function(path = "./data/shared_data") {
   if (!file.exists(paste0(path, "/TRY_5_GapFilledData_2020.zip"))) stop("the archive TRY_5_GapFilledData_2020.zip has to be manually placed in your local project/data/shared_data")
   if (!file.exists(paste0(path, "/TRY_5_GapFilledData_2020/input_data/trait.info.csv"))) {
      unzip(
         zipfile = paste0(path, "/TRY_5_GapFilledData_2020.zip"),
         files = c(
            "TRY_5_GapFilledData_2020/input_data/trait.info.csv",
            "TRY_5_GapFilledData_2020/input_data/hierarchy.info.csv"),
         exdir = path, overwrite = TRUE
      )
   }

   ## loading data
   try_raw <- data.table::fread(
      file = './data/shared_data/TRY_5_GapFilledData_2020/input_data/trait.info.csv',
      sep = ",", header = TRUE
   )

   hierarchy <- data.table::fread(
      file = './data/shared_data/TRY_5_GapFilledData_2020/input_data/hierarchy.info.csv',
      sep = ",", header = TRUE, select = c("V1", "Species")
   )

   ## replacing trait names
   trait_codes <- data.table::fread(
      file = './data/shared_data/TRY_trait_codes.csv',
      sep = ",", header = TRUE, skip = 1
   )

   long_names <- trait_codes$`Trait Name`[match(
      gsub(pattern = '[^0-9]', replacement = '',x = colnames(try_raw), perl = TRUE),
      as.character(trait_codes$TraitID))]
   if (anyNA(long_names)) warning("Missing trait code definition in trait table")

   new_trait_names <- data.table::fifelse(
      test = is.na(long_names),
      yes = gsub(pattern = '[^0-9]', replacement = '', x = colnames(try_raw), perl = TRUE),
      no = long_names
   )

   data.table::setnames(try_raw, new_trait_names)

   # adding species names and returning
   return(
      try_raw[hierarchy, on = "V1"] # data.table style join
   )
}
