#------------------------------------------------------------------------------#
#                              Replace Backtick                                #
#------------------------------------------------------------------------------#
#' ReplaceBacktick
#'
#' \code{ReplaceBacktick} Replace backtick
#'
#' Replaces backticks with single quotes.
#'
#' @usage ReplaceBacktick$new(x)$execute()
#'
#' @template textStudioParams
#' @template textStudioMethods
#' @template textStudioClasses
#' @template textStudioDesign
#'
#' @docType class
#' @author John James, \email{jjames@@dataScienceSalon.org}
#' @family TextStudio Classes
#' @export
ReplaceBacktick <- R6::R6Class(
  classname = "ReplaceBacktick",
  lock_objects = FALSE,
  lock_class = FALSE,
  inherit = TextStudio0,

  public = list(
    initialize = function(x) {
      private$..className <- "ReplaceBacktick"
      private$..methodName <- "initialize"
      private$..meta$object$name <-  "ReplaceBacktick"
      private$..x <- x
      private$..regex <- "\`"

      private$..replacement <- "'"
      private$..logs  <- LogR$new()
      invisible(self)
    }
  )
)