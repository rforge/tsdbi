\name{TShistQuoteMethods}
\alias{histQuote}

\alias{TSconnect,histQuoteConnection,missing-method}
\alias{TSget,character,TShistQuoteConnection-method}
\alias{TSdates,character,TShistQuoteConnection-method}
\alias{TSdescription,character,TShistQuoteConnection-method}
\alias{TSdoc,character,TShistQuoteConnection-method}
\alias{TSlabel,character,TShistQuoteConnection-method}
\alias{TSsource,character,TShistQuoteConnection-method}

\alias{TShistQuoteConnection-class}

\title{Methods to wrap get.hist.quote for TSdbi Generics}
\description{Get a time series (matrix) from stock quote URL}
\usage{
    histQuote(...) 
    \S4method{TSconnect}{histQuoteConnection,missing}(q, dbname, ...)
    \S4method{TSget}{character,TShistQuoteConnection}(
	serIDs, con, TSrepresentation = options()$TSrepresentation, 
	tf = NULL, start = tfstart(tf), end = tfend(tf), names=serIDs, 
	quote = "Close", quiet = TRUE, repeat.try=3, ...)
    \S4method{TSdates}{character,TShistQuoteConnection}(
	serIDs, con, vintage=NULL, panel=NULL, ... )  
    \S4method{TSdescription}{character,TShistQuoteConnection}(x, con, ... )  
    \S4method{TSdoc}{character,TShistQuoteConnection}(x, con, ... )  
    \S4method{TSlabel}{character,TShistQuoteConnection}(x, con, ... )  
    \S4method{TSsource}{character,TShistQuoteConnection}(x, con, ... )  
}
\arguments{
    \item{q}{a string indicating a query interface to use, or a database connection object.}
    \item{dbname}{a string indicating a database or omitted if \code{q} ia a connection object.}
    \item{con}{a database connection object.}
    \item{serIDs}{identifiers for series on the database.}
    \item{vintage}{character string indicating vintage of the series on the 
        database (not supported by this database).}
    \item{panel}{character string indicating panel of the series on the 
        database (not supported by this database).}
    \item{x}{time series data(TSput), or 
      identifiers for series on the database (TSdoc and TSdescription).}
    \item{names}{optional character vector to use for series names in the R
    object.}
    \item{tf}{time frame for trimming data, passed to tfwindow.}
    \item{start}{time frame for trimming data, passed to tfwindow.}
    \item{end}{time frame for trimming data, passed to tfwindow.}
    \item{TSrepresentation}{time representation for returned series. 
          (See \code{TSget} in package \pkg{TSdbi}.)}
    \item{quote}{reference time (e.g. ''Close'') passed to \code{get.hist.quote}.}
    \item{quiet}{logical to suppress progress report, passed to \code{get.hist.quote}.}
    \item{repeat.try}{integer number of times to attempt retrieval before giving
          up.}
    \item{...}{Arguments passed to get.hist.quote.}
}
\value{Depends.}
\details{
These functions interface to a stock quote URL using get.hist.quote from the 
\code{tseries} package. Only URLs ''yahoo'' and ''oanda'' are supported.
\pkg{TShistQuote} is just a wrapper to \code{get.hist.quote}. No 
extra functionality is provided, only an interface that is consistent 
with \pkg{TSdbi}. The \pkg{TSdbi} function argument
\code{dbname} is mapped to \code{get.hist.quote} argument \code{provider}, and
\code{serId} to \code{instrument}.
Argument \code{quote} (ignored for provider 'oanda') is
set to ''Close'' by default, but can be specified.
\code{get.hist.quote} argument \code{retclass} is replaced by \pkg{TSdbi}
argument \code{TSrepresentation}. (See \code{TSget} in \pkg{TSdbi} for
more details on how this works.)

\pkg{TShistQuote} does not support writing data to the source URL.

The classes \code{histQuoteDriver} and \code{TShistQuoteConnection} extend classes
\code{DBIDriver} and  \code{DBIConnection} in the DBI package.

See the package vignette for additional examples.
}

\seealso{ 
\code{\link[TSdbi]{TSconnect}},
\code{\link[TSdbi]{TSdates}},
\code{\link[TSdbi]{TSget}},
\code{\link[tseries]{get.hist.quote}}
\code{\link[tframe]{tfwindow}},
}
\examples{
     con <- TSconnect("histQuote", dbname="yahoo") 
    x <- TSget("^ftse", con)
    require("tfplot")
    tfplot(x)
}
\keyword{ts}
