#==============================================================================#
#                               TextStudio0                                    #
#==============================================================================#
#' TextStudio0
#'
#' \code{TextStudio0} Abstract class  for the TextStudio family of classes.
#'
#' This abstract class defines a common interface and methods for the TextStudio
#' family of classes.
#'
#' @template textStudioParams
#' @template textStudioMethods
#' @template textStudioClasses
#' @template textStudioDesign
#'
#' @docType class
#' @author John James, \email{jjames@@dataScienceSalon.org}
#' @family TextStudio classes
#' @export
TextStudio0 <- R6::R6Class(
  classname = "TextStudio0",
  lock_objects = FALSE,
  lock_class = FALSE,
  inherit = Base,

  private = list(
    ..x = character(),
    ..regex = character(),
    ..replacement = character(),

    processDocument = function(document) {
      document$content <- gsub(private$..regex,
                      private$..replacement,
                      document$content, perl = TRUE)
      document$log(event = private$..className)
      return(document)
    },

    processCorpus = function() {
      docs <- private$..x$get()
      for (i in 1:length(docs)) {
        doc <- private$processDocument(docs[[i]])
        private$..x$attach(doc)
      }
      private$..x$log(event = private$..className)
      return(TRUE)
    }
  ),

  public = list(
    initialize = function(x, ...) { stop("Not implemented for this abstract/interface class.") },

    execute = function() {

      private$..methodName <- "execute"

      if ("Corpus" %in% class(private$..x)) {
        private$processCorpus()

      } else {
        private$processDocument(private$..x)
      }

      # Log it
      private$..event <- paste0("Executed ", class(self)[1], " on ",
                                private$..x$getName(), ". ")
      private$logIt()

      return(private$..x)
    },

    #-------------------------------------------------------------------------#
    #                           Visitor Methods                               #
    #-------------------------------------------------------------------------#
    accept = function(visitor)  {
      visitor$textStudio(self)
    }
  )
)