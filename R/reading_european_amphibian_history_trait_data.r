#' Reading the European amphibians life history trait database
#'
#' @description Reading, after downloading if needed, the European amphibians life-
#' history trait database, a supplementary file associated to the article:
#' A database of life-history traits of European amphibians, Audrey Trochet,
#' Sylvain Moulherat, Olivier Calvez, Virginie M Stevens, Jean Clobert,
#' Dirk SSchmeller. Biodiversity Data Journal 2: e4123. doi: 10.3897/BDJ.2.e4123
#'
#' @return A \code{data.table} containing only biomass (in g) and length
#' traits (in mm).
#' @export
#'

reading_european_amphibian_history_trait_data <- function() {
   if (!file.exists('./downloaded data/traits/european_amphibians_database3.csv')) {
      # suppdata::suppdata(x = '10.3897/BDJ.2.e4123', si = "European_Amphibians_Database3.xls")
      download.file(url = "http://pwt.pensoft.net//getfile.php?filename=oo_32985.xlsx", destfile = './cache/traits/European_Amphibians_Database3.xlsx', mode = 'wb')

      ead <- data.table::as.data.table(
         readxl::read_xlsx('./cache/traits/European_Amphibians_Database3.xlsx',
                           na = 'DD', range = 'Feuil1!A4:L90')
      )
      data.table::setnames(ead, paste(colnames(ead),
                                      ifelse(grepl('mass', colnames(ead)), 'in g',
                                             ifelse(grepl('length', colnames(ead)), 'in mm', '')
                                      )
                                 )
      )

      data.table::fwrite(x = ead,
                         file = './downloaded data/traits/european_amphibians_database3.csv',
                         dec = '.', sep = ','
      )
      file.remove('./cache/traits/European_Amphibians_Database3.xlsx')

      return(ead)
   } else {
      return(data.table::fread(file = './downloaded data/traits/european_amphibians_database3.csv',
                               dec = '.', sep = ',', header = TRUE))
   }
}
