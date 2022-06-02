#' Internal function - Creates all necessary folders in case they were not pushed to git
#'
#' @return No returned value. Side effects only
#'

create_folders <- function() {
   dir.create("./data", showWarnings = FALSE)
   dir.create("./data/cache", showWarnings = FALSE)
   dir.create("./data/cache/traits", showWarnings = FALSE)
   dir.create("./data/downloaded_data", showWarnings = FALSE)
   dir.create("./data/downloaded_data/traits", showWarnings = FALSE)
   dir.create("./data/shared_data", showWarnings = FALSE)
}
