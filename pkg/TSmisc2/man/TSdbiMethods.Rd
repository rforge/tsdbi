\name{TSmisc2Methods}

\alias{Quandl}
\alias{TSQuandlConnection-class}

\alias{TSconnect,QuandlConnection,missing-method}
\alias{TSget,character,TSQuandlConnection-method}
\alias{TSdoc,character,TSQuandlConnection-method}
\alias{TSdescription,character,TSQuandlConnection-method}
\alias{TSlabel,character,TSQuandlConnection-method}
\alias{TSsource,character,TSQuandlConnection-method}
\alias{TSdates,character,TSQuandlConnection-method}
\alias{TSexists,character,TSQuandlConnection-method}

\title{TSdbi Extensions to Wrap Several (in Development) Data Sources}
\description{Get a time series (matrix) from a variety of source URLs}
\usage{
    Quandl(...)

    \S4method{TSconnect}{QuandlConnection,missing}(q, dbname,
               api_key=NULL, ...)
    \S4method{TSget}{character,TSQuandlConnection}(serIDs, con, 
	TSrepresentation = getOption("TSrepresentation"), 
	tf = NULL, start = tfstart(tf), end = tfend(tf), names = NULL,
	quote = NULL, TSdescription = FALSE, TSdoc = FALSE, TSlabel=FALSE,
	TSsource=TRUE, vintage = NULL, ...)
    \S4method{TSdates}{character,TSQuandlConnection}(serIDs, 
        con=getOption("TSconnection"), vintage=NULL, panel=NULL, ...)
    \S4method{TSexists}{character,TSQuandlConnection}(serIDs, con,
           vintage=NULL, panel=NULL, ...)
    \S4method{TSdescription}{character,TSQuandlConnection}(x, con, ...)
    \S4method{TSdoc}{character,TSQuandlConnection}(x, 
                con=getOption("TSconnection"), ...)
    \S4method{TSlabel}{character,TSQuandlConnection}(x, con, ...)
    \S4method{TSsource}{character,TSQuandlConnection}(x, con, ...)
}
\arguments{
    \item{q}{A character string indicating the query interface to use, or
         a database connection object.}
    \item{dbname}{A character string indicating the name of the database 
         to which the connection should be
         established, omitted if \code{q} is a database connection object. 
	 The string should be the first part of Quandl identifier 
	 code ( before '/', e.g. 'NSE').}
    \item{con}{A TSconnection object.}
    \item{serIDs}{identifiers for series to extract. (Second part of Quandl
        identifier code, after  '/').}
    \item{x}{a series identifier for
       TSdescription and TSdoc or, for print, 
       a database connection as returned by TSconnect.}
    \item{api_key}{character string of Quandl access api_key.}
    \item{TSrepresentation}{time series representation to use for the result.}
    \item{names}{Optional character vector to use for series names. Defaults to
       serIDs.}
    \item{tf}{Optional time frame to use for truncating data. 
       (See \code{tfwindow}.)}
    \item{start}{Optional start date to use for truncating data.)}
    \item{end}{Optional end date to use for truncating data.)}
    \item{TSdescription}{TRUE or FALSE indicating whether description 
       should be extracted}
    \item{TSdoc}{TRUE or FALSE indicating whether documentation 
       should be extracted.}
    \item{TSlabel}{For compatibility with other TS packages. Not supported in
        Quandl}
    \item{TSsource}{If TRUE (default) TSsource in the result is set to
        "Quandl".}
    \item{quote}{reference item (e.g. ''Close''). See details.}
    \item{vintage}{Vintage to be supplied (if available on dbname).}
    \item{panel}{Panel to be supplied (if available).}
    \item{...}{Arguments passed to other methods.}
}
\value{depends.}
\details{
These are methods for \pkg{TSdbi} . See the package \pkg{TSdbi} for details 
and see the vignette distributed with the \pkg{TSdata} package for more 
complete examples.

Interfaces in this package are generally less stable or in development compared
with other \pkg{TS*} packages.

The package provides a wrapper to the \pkg{Quandl} package to provide
a \pkg{TSdbi} API for users. Function \code{TSConnect} sets the information used
for the connection. \code{TSget} retrieves data.
Both \code{start} and \code{end} can be either date objects or 
character strings.

The Quandl access api_key can be specified either as an argument to \code{TSConnect} (\code{api_key="chars"}) or in a file .Quandl.cnf in the user's
home directory, or in an environment variable 'QUANDL_API_KEY', or using the 
\pkg{Quandl} \code{Quandl.api_key} function. This last will require the user to
attach \pkg{Quandl} in order to set it. 
The search will be done in that order and the first non-\code{NULL} value used. If no api_key is found then access will be tried without a api_key, but this will be subject to the limit imposed by Quandl.

The argument \code{quote} can be used to select a subset of the data requested,
in the case of a multivariate dataset. For example, daily stock or
stock index results may have columns "Open", "High", "Low",  "Close", ... . 
The argument \code{quote} can be used to select from these.  
Note that when argument \code{quote} is specified to select a subset of the dataset requested, capitalization is important.
}

\seealso{ 
\code{\link[TSdbi]{TSdbi-package}},
\code{\link[TSdbi]{TSconnect}},
\code{\link[TSdbi]{TSdates}},
\code{\link[TSdbi]{TSget}},
\code{\link[tframe]{tfwindow}},
\code{\link[Quandl]{Quandl}}
}
\examples{
 require("tfplot")
 \dontrun{
  con <- TSconnect("Quandl", dbname="NSE")
  x  <- TSget("OIL", con, start="2001-01-01")
  start(x)
  end(x)
  
  x  <- TSget("OIL", con, start=as.Date("2001-01-01")) 
  tfplot(x)
  
  dimnames(x)[2]
  x <- TSget("OIL", con, quote="Open")

  tfplot(x)
  }
}
\keyword{ts}

