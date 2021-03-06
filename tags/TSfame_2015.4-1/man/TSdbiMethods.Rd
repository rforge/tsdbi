\name{TSfameMethods}
\alias{fameLocal}
\alias{fameServer}

\alias{TSconnect,TSfameLocalConnection,missing-method}
\alias{TSget,character,TSfameLocalConnection-method}
\alias{TSput,ANY,character,TSfameLocalConnection-method}
\alias{TSdelete,character,TSfameLocalConnection-method}
\alias{TSdoc,character,TSfameLocalConnection-method}
\alias{TSdescription,character,TSfameLocalConnection-method}
\alias{TSlabel,character,TSfameLocalConnection-method}
\alias{TSsource,character,TSfameLocalConnection-method}
\alias{TSdates,character,TSfameLocalConnection-method}
\alias{TSexists,character,TSfameLocalConnection-method}
\alias{TSvintages,TSfameLocalConnection-method}

\alias{TSconnect,TSfameServerConnection,missing-method}
\alias{TSget,character,TSfameServerConnection-method}
\alias{TSput,ANY,character,TSfameServerConnection-method}
\alias{TSdelete,character,TSfameServerConnection-method}
\alias{TSdoc,character,TSfameServerConnection-method}
\alias{TSdescription,character,TSfameServerConnection-method}
\alias{TSlabel,character,TSfameServerConnection-method}
\alias{TSsource,character,TSfameServerConnection-method}
\alias{TSdates,character,TSfameServerConnection-method}
\alias{TSexists,character,TSfameServerConnection-method}
\alias{TSvintages,TSfameServerConnection-method}

\alias{TSfameLocalConnection-class}
\alias{TSfameServerConnection-class}

\title{TSdbi fame Methods}
\description{Methods for TSdbi fame time series database connection.}
\usage{
   fameLocal(...)
   fameServer(...)
   \S4method{TSconnect}{TSfameLocalConnection,missing}(q, dbname, 
	accessMode = if (file.exists(dbname)) "shared" else "create", 
	current = NA, ...)
    \S4method{TSconnect}{TSfameServerConnection,missing}(q, dbname, 
        service = "", host = "", user = "", password = "", current = NA, ...)

    \S4method{TSget}{character,TSfameLocalConnection}(serIDs, con, 
	TSrepresentation = getOption("TSrepresentation"), 
	tf = NULL, start = tfstart(tf), end = tfend(tf), names = NULL,
	TSdescription = FALSE, TSdoc = FALSE, TSlabel=FALSE, TSsource=TRUE,
        vintage=getOption("TSvintage"),   ...)
    \S4method{TSget}{character,TSfameServerConnection}(serIDs, con, 
	TSrepresentation = getOption("TSrepresentation"), 
	tf = NULL, start = tfstart(tf), end = tfend(tf), names = NULL,
	TSdescription = FALSE, TSdoc = FALSE, TSlabel=FALSE, TSsource=TRUE,
        vintage=getOption("TSvintage"),   ...)

    \S4method{TSput}{ANY,character,TSfameLocalConnection}(x, serIDs=seriesNames(x), 
	con, TSdescription.=TSdescription(x), 
	TSdoc.=TSdoc(x), TSlabel.=NULL, TSsource.=NULL, warn = TRUE, ...)
    \S4method{TSput}{ANY,character,TSfameServerConnection}(x, serIDs=seriesNames(x), 
	con, TSdescription.=TSdescription(x), 
	TSdoc.=TSdoc(x), TSlabel.=NULL, TSsource.=NULL, warn = TRUE, ...)

    \S4method{TSdates}{character,TSfameLocalConnection}(serIDs, con, 
	vintage=getOption("TSvintage"), panel=NULL, ...)
    \S4method{TSdates}{character,TSfameServerConnection}(serIDs, con, 
	vintage=getOption("TSvintage"), panel=NULL, ...)

    \S4method{TSexists}{character,TSfameLocalConnection}(
	serIDs, con, vintage=NULL, panel=NULL, ...)
    \S4method{TSexists}{character,TSfameServerConnection}(
	serIDs, con, vintage=NULL, panel=NULL, ...)

    \S4method{TSdelete}{character,TSfameLocalConnection}(serIDs, con,  
            vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
    \S4method{TSdelete}{character,TSfameServerConnection}(serIDs, con,  
            vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)

    \S4method{TSdescription}{character,TSfameLocalConnection}(x, con, ...)
    \S4method{TSdescription}{character,TSfameServerConnection}(x, con, ...)

    \S4method{TSdoc}{character,TSfameLocalConnection}(x, con, ...)
    \S4method{TSdoc}{character,TSfameServerConnection}(x, con, ...)

    \S4method{TSlabel}{character,TSfameLocalConnection}(x, con, ...)
    \S4method{TSlabel}{character,TSfameServerConnection}(x, con, ...)

    \S4method{TSsource}{character,TSfameLocalConnection}(x, con, ...)
    \S4method{TSsource}{character,TSfameServerConnection}(x, con, ...)

    \S4method{TSvintages}{TSfameLocalConnection}(con)
    \S4method{TSvintages}{TSfameServerConnection}(con)
}
\arguments{
    \item{q}{A character string indicating the query interface to use, or
         a database connection object.}
    \item{dbname}{The name of the  [server and] database to which the 
         connection should be
         established, omitted if \code{q} is a database connection object.}
    \item{con}{A database connection.}
    \item{serIDs}{identifiers for series to extract.}
    \item{vintage}{character string indicating vintage of the series on the 
        databases.}
    \item{panel}{character string indicating panel of the series on the 
        database (not supported by this database).}
    \item{x}{data series to put on the database, or a series identifier for
       TSdescription and TSdoc or, for print, 
       a database connection as returned by TSconnect.}
    \item{TSrepresentation}{time series representation to use for the result.}
    \item{names}{Optional character vector to use for series names. Defaults to
       serIDs unless vintage is a vector, in which case it defaults to vintage.}
    \item{tf}{Optional tframe to use for truncating data. (See \code{tfwindow}.)}
    \item{start}{Optional start date to use for truncating data. (See \code{tfwindow}.)}
    \item{end}{Optional end date to use for truncating data. (See \code{tfwindow}.)}
    \item{TSdescription}{TRUE or FALSE indicating whether description 
       should be extracted}
    \item{TSdescription.}{Description to put on the database.}
    \item{TSdoc}{TRUE or FALSE indicating whether documentation 
       should be extracted.}
    \item{TSdoc.}{Documentation to put on the database.}
    \item{TSlabel}{For compatibility with other TS packages. Not supported in
        Fame}
    \item{TSlabel.}{For compatibility with other TS packages. Not supported in
        Fame}
    \item{TSsource}{For compatibility with other TS packages. Not supported in
        Fame}
    \item{TSsource.}{For compatibility with other TS packages. Not supported in
        Fame}
    \item{warn}{Logical indicating if warning messages should be suppressed.} 
    \item{accessMode}{Optional character indicating the mode to use when opening 
          the Fame database when establishing the first connection. After the 
	  first connection, "read" will be used for reading and "update" for writing.}
    \item{host}{A character string indicating a server.}
    \item{service}{A character string indicating a server port number.}
    \item{user}{A character string indicating a user id (if needed).}
    \item{password}{A character string indicating a password (if needed).}
    \item{current}{A character string indicating a vintage that should be
      considered the current vintage (see details).}
   \item{...}{Arguments passed to other methods.}
}
\value{depends.}
\details{
These are fame methods for \pkg{TSdbi}. See the package \pkg{TSdbi} for details 
and see the vignette distributed with this package for more complete examples.

This package provides a wrapper to the \pkg{fame} package to provide a 
\pkg{TSdbi} API for users. The \code{TSfameLocalConnection} establishes a connection
using the locally fame which can access local databases or databases on a remote
server, specified by the server name followed by a space and the database name.
The \code{TSfameServerConnection} establishes a connection to a remote server
using one of Fame's remote server protocols. See package \pkg{fame} for more
specific details.

There is a simplistic mechanism for accessing vintages of data stored in 
different Fame databases. To use this, the \code{dbname} argument to 
\code{TSconnect} should be a vector of character strings indicating the 
databases, with names of the elements indicating the vintages. The 
\code{vintage} argument to \code{TSget} is then a character vector used to 
select a subset of \code{dbname}. The \code{dbname} argument to 
\code{TSconnect} can also be specified to indicate the version that should be
considered current. (That is, the user needs to know that information and specify it,
rather than having it supplied by the database.) In other respects the vintages 
support is then similar to other TSdbi packages such as \pkg{TSMySQL}, and 
examples in those packages may be useful. Some examples are also provided in 
the \pkg{TSfame} Guide vingette.
}

\seealso{ 
\code{\link[TSdbi]{TSdbi-package}},
\code{\link[DBI]{dbConnect}},
\code{\link[TSdbi]{TSput}}
\code{\link[fame]{getfame}}
}
\examples{
   require("tfplot")
   con <- try(TSconnect(dbDriver("fame"), dbname="test.db"))
    if(! inherits(con, "try-error")) {
      z <- ts(rnorm(100), start=c(1975,1), frequency=12)
      seriesNames(z) <- "random1"
      if(TSexists("random1", con)) TSreplace(z, con) else
      TSput(z, con)
      z1 <- TSget("random1", con)
      tfplot(z1)
      z <- ts(matrix(rnorm(100),50,2), start=c(1975,1), frequency=4)
      seriesNames(z) <- c("random2","random3")
      if(TSexists("random2", con) |
         TSexists("random3", con) ) TSreplace(z, con) else
      TSput(z, con)
      z2 <- TSget("random2", con)
      tfplot(z2)
      TSdates("D1", con)
      TSdates("random2", con)
      TSdates(c("random1","random2","random3"), con)
      TSmeta("random2", con)
      options(TSconnection=con)
      z2 <- TSget(c("random2","random3"))
      z <- TSdates(c("D1","random2","random3"))
      print(z)
      TSmeta("random2")
      TSdelete("random1", con)
      TSdelete("random2")
      dbDisconnect(con)
      }
}
\keyword{ts}

