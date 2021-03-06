% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bookmark-state.R
\name{bookmarkButton}
\alias{bookmarkButton}
\title{Create a button for bookmarking/sharing}
\usage{
bookmarkButton(label = "Bookmark...", icon = shiny::icon("link", lib =
  "glyphicon"),
  title = "Bookmark this application's state and get a URL for sharing.",
  ..., id = "._bookmark_")
}
\arguments{
\item{label}{The contents of the button or link--usually a text label, but
you could also use any other HTML, like an image.}

\item{icon}{An optional \code{\link{icon}} to appear on the button.}

\item{title}{A tooltip that is shown when the mouse cursor hovers over the
button.}

\item{...}{Named attributes to be applied to the button or link.}

\item{id}{An ID for the bookmark button. The only time it is necessary to set
the ID unless you have more than one bookmark button in your application.
If you specify an input ID, it should be excluded from bookmarking with
\code{\link{setBookmarkExclude}}, and you must create an observer that
does the bookmarking when the button is pressed. See the examples below.}
}
\description{
A \code{bookmarkButton} is a \code{\link{actionButton}} with a default label
that consists of a link icon and the text "Bookmark...". It is meant to be
used for bookmarking state.
}
\examples{
## Only run these examples in interactive sessions
if (interactive()) {

# This example shows how to use multiple bookmark buttons. If you only need
# a single bookmark button, see examples in ?enableBookmarking.
ui <- function(request) {
  fluidPage(
    tabsetPanel(id = "tabs",
      tabPanel("One",
        checkboxInput("chk1", "Checkbox 1"),
        bookmarkButton(id = "bookmark1")
      ),
      tabPanel("Two",
        checkboxInput("chk2", "Checkbox 2"),
        bookmarkButton(id = "bookmark2")
      )
    )
  )
}
server <- function(input, output, session) {
  # Need to exclude the buttons from themselves being bookmarked
  setBookmarkExclude(c("bookmark1", "bookmark2"))

  # Trigger bookmarking with either button
  observeEvent(input$bookmark1, {
    session$doBookmark()
  })
  observeEvent(input$bookmark2, {
    session$doBookmark()
  })
}
enableBookmarking(store = "url")
shinyApp(ui, server)
}
}
\seealso{
\code{\link{enableBookmarking}} for more examples.
}
