#' Reading the Ecological traits of the world’s primates database
#'
#' @description Reading, after downloading if needed, the Ecological traits of
#' the world’s primates. The data is stored in a Figshare repository (reference:
#' E. Jones, Kate; Bielby, Jon; Cardillo, Marcel; A. Fritz, Susanne;
#' O'Dell, Justin; David L. Orme, C.; et al. (2016): Full Archive. Wiley.
#' Dataset. https://doi.org/10.6084/m9.figshare.3531875.v1
#' The associated article is: Jones, K.E., Bielby, J., Cardillo, M., Fritz, S.A.,
#'  O'Dell, J., Orme, C.D.L., Safi, K., Sechrest, W., Boakes, E.H., Carbone, C.,
#'  Connolly, C., Cutts, M.J., Foster, J.K., Grenyer, R., Habib, M.,
#'  Plaster, C.A., Price, S.A., Rigby, E.A., Rist, J., Teacher, A.,
#'  Bininda-Emonds, O.R.P., Gittleman, J.L., Mace, G.M. and Purvis, A. (2009),
#'  PanTHERIA: a species‐level database of life history, ecology, and geograph
#'   of extant and recently extinct mammals. Ecology, 90: 2648-2648.
#'   https://doi.org/10.1890/08-1494.1
#'
#' @return A \code{data.table} containing body mass and body length from the
#' PanTHERIA_1-0_WR05_Aug2008.txt table which follows Wilson and Reeder 2005
#' taxonomy. A list of synonyms extracted from SppSynonymID1.0.txt is added.
#' @export
#'

reading_panTHERIA <- function() {
   create_folders()
   # downloading from figshare, unzipping, deleting the archive.
   if (!file.exists('./data/downloaded_data/traits/panTHERIA/PanTHERIA_1-0_WR05_Aug2008.txt')) {
      download.file(
         url = 'https://ndownloader.figshare.com/files/5604752',
         destfile = './data/cache/traits/PanTHERIA_ECOL_90_184.zip',
         mode = 'wb'
      )
      unzip(zipfile = './data/cache/traits/PanTHERIA_ECOL_90_184.zip',
            files = c(
               "PanTHERIA_1-0_WR05_Aug2008.txt",
               "SppSynonymID1.0.txt",
               "metadata.htm"
            ),
            exdir = './data/downloaded_data/traits/PanTHERIA')
   }
   # reading the trait table
   selected_columns <- which(grepl("^MSW05_|^5-|^13-", data.table::fread("./data/downloaded_data/traits/panTHERIA/PanTHERIA_1-0_WR05_Aug2008.txt", sep = '\t', header = FALSE, nrows = 1)))
   p <- data.table::fread("./data/downloaded_data/traits/panTHERIA/PanTHERIA_1-0_WR05_Aug2008.txt", na.strings = '-999.00', sep = '\t', dec = '.', header = TRUE, select = selected_columns)
   # reading the taxonomy table
   tax <- data.table::fread(
      file = "./data/downloaded_data/traits/panTHERIA/SppSynonymID1.0.txt",
      na.strings = '-999.00', sep = '\t', header = TRUE
   )

   # adding a synonym column to the trait table
   data.table::set(x = tax, j = "sp", value = paste(tax$Genus, tax$Species))



   for (species_i in unique(tax$MSW05Binomial)) {
      selected_rows <- which(tax$MSW05Binomial == species_i)
      data.table::set(
         x = tax, i = selected_rows,
         j = "synonyms",
         value = data.table::fifelse(
            tax$MSW05Trinomial[selected_rows] == 'None',
            paste(unique(unlist(tax$sp[selected_rows], tax$MSW93Binomial[selected_rows])), collapse = '; '),
            paste(unique(unlist(tax$sp[selected_rows], tax$MSW93Binomial[selected_rows], tax$MSW05Trinomial[selected_rows])), collapse = '; ')
         )
      )
   }

   return(
      merge(p, unique(tax[, c("MSW05Binomial", "synonyms")]), by.x = 'MSW05_Binomial', by.y = 'MSW05Binomial', all.x = TRUE)
   )
}

