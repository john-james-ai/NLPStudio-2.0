#------------------------------------------------------------------------------#
#                         Replace HTML                                         #
#------------------------------------------------------------------------------#
#' ReplaceHTML
#'
#' \code{ReplaceHTML}  Replace HTML Markup
#'
#' A wrapper for \code{\link[textclean]{replace_html}} replaces HTML markup.
#' The angle braces are removed and the HTML symbol markup is replaced
#' with equivalent symbols.
#' Source \url{https://cran.r-project.org/web/packages/textclean/textclean.pdf}
#'
#' @usage ReplaceHTML$new(x, symbol = TRUE)$execute()
#'
#' @template textStudioParams
#' @param symbol Logical. If codeTRUE the symbols are retained with appropriate replacements.
#' If FALSE they are removed.
#' @template textStudioMethods
#' @template textStudioClasses
#' @template textStudioDesign
#'
#' @examples
#'
#' @return \code{ReplaceHTML} Returns a vector with HTML markup replaced.
#'
#' @docType class
#' @author John James, \email{jjames@@dataScienceSalon.org}
#' @family TextStudio Classes
#' @export
ReplaceHTML <- R6::R6Class(
  classname = "ReplaceHTML",
  lock_objects = FALSE,
  lock_class = FALSE,
  inherit = TextStudio0,

  private = list(
    ..symbol = logical(),

    processDocument = function(content) {
      content <- textclean::replace_html(x = content,
                                             symbol = private$..symbol)
      return(content)
    }
  ),

  public = list(
    initialize = function(x, symbol = TRUE) {
      private$..className <- "ReplaceHTML"
      private$..methodName <- "initialize"
      private$..meta$object$name <-  "ReplaceHTML"
      private$..x <- x
      private$..symbol <- symbol
      private$..logs  <- LogR$new()
      invisible(self)
    }
  )
)