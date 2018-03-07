## ---- IOCSV
#==============================================================================#
#                                      IOCSV                                   #
#==============================================================================#
#' IOCSV
#'
#'
#' \code{IOCSV} Class responsible for reading and writing csv files.
#'
#' @template ioStrategyMethods
#'
#' @template ioStrategyParams
#'
#' @template ioStrategyReturn
#'
#' @docType class
#' @author John James, \email{jjames@@DataScienceSalon.org}
#' @family Input / Output Classes
#' @export
IOCSV <- R6::R6Class(
  classname = "IOCSV",
  lock_objects = TRUE,
  lock_class = FALSE,
  inherit = Entity,
  public = list(

    #-------------------------------------------------------------------------#
    #                           Core Methods                                  #
    #-------------------------------------------------------------------------#
    read = function(path, header = TRUE) {

      private$..logs <- LogR$new()

      fileName <- basename(path)

      if (file.exists(path)) {
        content <- read.csv(file = path, header = header,
                            stringsAsFactors = FALSE,
                            sep = ",", quote = "\"'")
        private$..state <- paste0("Successfully read ", fileName, ".")
        private$..meta[["accessed"]] <- Sys.time()
        self$logIt()
      } else {
        private$..state <- paste0('Unable to read ', fileName, '. ',
                                  'File does not exist.')
        self$logIt("Error")
        stop()
      }
      return(content)
    },

    write = function(path, content) {

      private$..logs <- LogR$new()

      fileName <- basename(path)
      dirName <- dirname(path)

      # Create directory if necessary
      dir.create(dirName, showWarnings = FALSE, recursive = TRUE)

      write.csv(content, file = path, row.names = FALSE)

      private$..state <- paste0("Successfully wrote ", fileName, ".")
      self$logIt()

      invisible(self)
    }
  )
)