\name{TSOracleMethods}
\alias{Oracle}

\alias{TSconnect,OracleConnection,missing-method}
\alias{TSget,character,TSOracleConnection-method}
\alias{TSput,ANY,character,TSOracleConnection-method}
\alias{TSdelete,character,TSOracleConnection-method}
\alias{TSdescription,character,TSOracleConnection-method}
\alias{TSdoc,character,TSOracleConnection-method}
\alias{TSlabel,character,TSOracleConnection-method}
\alias{TSsource,character,TSOracleConnection-method}
\alias{TSdates,character,TSOracleConnection-method}
\alias{TSvintages,TSOracleConnection-method}

\alias{TSOracleConnection-class}

\title{TSdbi Oracle Methods}
\description{Methods for TSdbi Oracle time series dtabase connection.}
\usage{
    Oracle(...)
    \S4method{TSconnect}{OracleConnection,missing}(q, dbname, ...)
    \S4method{TSget}{character,TSOracleConnection}(serIDs, con, 
       TSrepresentation=options()$TSrepresentation,
       tf=NULL, start=tfstart(tf), end=tfend(tf), names=NULL, 
       TSdescription=FALSE, TSdoc=FALSE, TSlabel=FALSE, TSsource=TRUE,
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"),   ...)
    \S4method{TSput}{ANY,character,TSOracleConnection}(x, serIDs, con, Table=NULL, 
       TSdescription.=TSdescription(x), TSdoc.=TSdoc(x), TSlabel.=TSlabel(x),
        TSsource.=TSsource(x),  
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"),  ...)
    \S4method{TSdates}{character,TSOracleConnection}(serIDs, con,  
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
    \S4method{TSdelete}{character,TSOracleConnection}(serIDs, con,  
   vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
    \S4method{TSdescription}{character,TSOracleConnection}(x, con, ...)
    \S4method{TSdoc}{character,TSOracleConnection}(x, con, ...)
    \S4method{TSlabel}{character,TSOracleConnection}(x, con, ...)
    \S4method{TSsource}{character,TSOracleConnection}(x, con, ...)
    \S4method{TSvintage}{TSOracleConnection}(con)
    \S4method{dropTStable}{OracleConnection,character,ANY}(con, Table, 
                           yesIknowWhatIamDoing=FALSE)
}
\arguments{
    \item{q}{A character string indicating the query interface to use, or
         a database connection object.}
    \item{dbname}{The name of the database to which the connection should be
         established, omitted if \code{q} is a database connection object.}
    \item{con}{A database connection.}
    \item{serIDs}{identifiers for series to extract.}
    \item{x}{data series to put on the database, or a series identifier for
       TSdescription and TSdoc or, for print, 
       a database connection as returned by TSconnect.}
    \item{TSrepresentation}{time series representation to use for the result.}
    \item{names}{Optional character vector to use for series names.}
    \item{tf}{Optional tframe to use for truncating data. (See \code{tfwindow}.)}
    \item{start}{Optional start date to use for truncating data. (See \code{tfwindow}.)}
    \item{end}{Optional end date to use for truncating data. (See \code{tfwindow}.)}
    \item{TSdescription}{TRUE or FALSE indicating whether description 
       should be extracted}
    \item{TSdescription.}{Description to put on the database.}
    \item{TSdoc}{TRUE or FALSE indicating whether documentation 
       should be extracted.}
    \item{TSdoc.}{Documentation to put on the database.}
    \item{TSlabel}{TRUE or FALSE indicating whether series label 
       should be extracted.}
    \item{TSlabel.}{Short series label to put on the database.}
    \item{TSsource}{TRUE or FALSE indicating whether source indication 
       should be extracted.}
    \item{TSsource.}{Source indication to put on the database.}
    \item{Table}{Character string indicating database table. (In TSput this is 
    	necessary if it cannot be determined automatically).}
    \item{vintage}{Vintage to be supplied (if supported by db).}
    \item{panel}{Panel to be supplied (if supported by db).}
    \item{yesIknowWhatIamDoing}{logical to help prevent accidents.}
    \item{...}{Arguments passed to other methods.}
}
\value{depends.}
\details{
These are Oracle methods for \pkg{TSdbi}. See the \pkg{TSdbi} for details and
see the vignette distributed with package \pkg{TSdata} for more complete examples.
Package \pkg{TSsql} is required for functions createTSdbTables() and
removeTSdbTables().
Typically createTSdbTables() will only be done once, and the tables
will not be removed. These steps are done in the example below.
}

\seealso{ 
\code{\link[TSdbi]{TSdbi-package}},
\code{\link[DBI]{dbConnect}},
\code{\link[TSdbi]{TSput}}
}
\examples{
   require("tfplot")
   conInit <- try(TSconnect(dbDriver("Oracle"), dbname="test"))
    if(! inherits(conInit, "try-error")) {
      require("TSsql")
      createTSdbTables(conInit, index=FALSE)
      con <- TSconnect(dbDriver("MySQL"), dbname="test")
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
       \dontshow{removeTSdbTables(con, yesIknowWhatIamDoing=TRUE)} 
      }
    con <- try(TSconnect(dbDriver("Oracle"), dbname="ets"))
    if(! inherits(con, "try-error")) {
      TSmeta("B103", con)
      z1 <- TSget("B103", con)
      tfplot(z1)
      z2 <- TSget(c("B103", "B104"), con)
      tfplot(z2)
      options(TSconnection=con)
      TSmeta("B103")
      z2 <- TSget(c("B103","B104"))
      TSmeta(z2)
      TSdates("D1", con)
      TSdates("B103", con)
      TSdates(c("D1","B103","B104"), con)
      z <- TSdates(c("D1","B103","B104"))
      print(z)
      start(z)
      end(z)
      }
}
\keyword{ts}

