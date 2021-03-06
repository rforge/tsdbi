\name{Internal}
\alias{dbConnect,histQuoteDriver-method}
\alias{dbDisconnect,histQuoteConnection-method}

\alias{histQuoteDriver-class}

\title{Internal DBI Methods for histQuote}
\description{Pretend histQuote has DBI methods for connections.}
\usage{
    \S4method{dbConnect}{histQuoteDriver}(drv, dbname, ...)
    \S4method{dbDisconnect}{histQuoteConnection}(conn, ...)
}
\arguments{
    \item{drv}{a database driver object.}
    \item{dbname}{a character string indicating the name of a database.}
    \item{conn}{a database connection object.}
    \item{...}{Arguments passed to methods.}
}
\value{Depends.}
\details{
These methods just fake DBI connections. 
}
\keyword{internal}
