#==============================================================================#
#                               TextStudio                                     #
#==============================================================================#
#' TextStudio
#'
#' \code{TextStudio} Class for performing text cleaning and preprocessing
#'
#' @template textStudioClasses
#'
#' @section TextStudio methods:
#' \strong{Core Methods:}
#'  \itemize{
#'   \item{\code{new()}}{Method for instantiating a TextStudio.}
#'   \item{\code{addCommand()}}{Method that adds a text processing command to the queue. }
#'   \item{\code{removeCommand()}}{Method that for removing a command from the queue.}
#'   \item{\code{execute()}}{Method that executes the job queue. }
#'   \item{\code{getResult()}}{Method that returns the object following execution of the job queue. }
#'  }
#'
#' \strong{Other Methods:}
#'  \itemize{
#'   \item{\code{accept(visitor)}}{Accepts a visitor object. Not implemented for this abstract class}
#'   \item{\code{logIt(level = 'Info')}}{Logs events relating to the TextStudio.}
#'  }
#'
#' @section Parameters:
#' @param object The object to be processed.
#' @param queue The job queue containing text processing commands.
#'
#' @docType class
#' @author John James, \email{jjames@@datasciencesalon.org}
#' @family TextStudio classes
#' @export
TextStudio <- R6::R6Class(
  classname = "TextStudio",
  lock_objects = FALSE,
  lock_class = FALSE,
  inherit = Base,

  private = list(
    ..x = character(),
    ..jobQueue = list()
  ),

  public = list(

    #-------------------------------------------------------------------------#
    #                           Core Methods                                  #
    #-------------------------------------------------------------------------#
    initialize = function(x) {

      # Instantiate variables
      private$..className <- 'TextStudio'
      private$..methodName <- 'initialize'
      private$..logs <- LogR$new()

      # Validation
      private$..params <- list()
      private$..params$x <- x
      if (private$validateParams()$code == FALSE) stop()

      private$..x <- x

      # Create log entry
      private$..event <- paste0("TextStudio object instantiated.")
      private$logIt()

      invisible(self)
    },

    #-------------------------------------------------------------------------#
    #                           Command Management                            #
    #-------------------------------------------------------------------------#
    addCommand = function(cmd) {

      private$..methodName <- "addCommand"

      if (!c("TextStudio0") %in% class(cmd)) {
        private$..event <- paste0("Invalid text command object. Object must be ",
                                  "of the TextStudio0 classes.  See ?", class(self)[1],
                                  " for further assistance.")
        private$logIt("Error")
        stop()
      }

      name <- cmd$getName()
      private$..jobQueue[[name]] <- cmd

      private$..event <- paste0("Added ", cmd$getName(), " to ", private$..x$getName(),
                                " job queue." )
      private$logIt()

      invisible(self)
    },

    removeCommand = function(cmd) {

      private$..methodName <- "removeCommand"

      if (!c("TextStudio0") %in% class(cmd)) {
        private$..event <- paste0("Invalid text command object. Object must be ",
                                  "of the TextStudio0 classes.  See ?", class(self)[1],
                                  " for further assistance.")
        private$logIt("Error")
        stop()
      }

      name <- cmd$getName()
      private$..jobQueue[[name]] <- NULL

      private$..event <- paste0("Removed ", cmd$getName(), " from ", private$..x$getName(),
                                " job queue." )
      private$logIt()

      invisible(self)

    },

    execute = function() {

      private$..methodName <- "execute"

      for (i in 1:length(private$..jobQueue)) {
        private$..x <- private$..jobQueue[[i]]$execute(private$..x)
      }

      private$..event <- paste0("Processed text processing commands on ",
                                private$..x$getName(), "." )
      private$logIt()

      invisible(self)

    },

    getResult = function() {
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