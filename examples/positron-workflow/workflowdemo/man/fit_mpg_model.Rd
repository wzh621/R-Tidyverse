\name{fit_mpg_model}
\alias{fit_mpg_model}
\title{Fit the Teaching MPG Regression}
\usage{fit_mpg_model(data)}
\arguments{\item{data}{A data frame with finite numeric mpg, wt, and hp columns.}}
\description{Validate the data and fit mpg as a function of wt and hp.}
\value{An object of class \code{lm}.}
\examples{
fit_mpg_model(datasets::mtcars)
}
