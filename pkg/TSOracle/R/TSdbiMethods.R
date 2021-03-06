Oracle <- function(...){
  args <- pmatch(names(list(...)), names(formals(ROracle::Oracle)) )
  do.call(ROracle::Oracle, list(...)[!is.na(args)])
  }

setClass("TSOraConnection", contains=c("OraConnection", "conType", "TSdb"))


setMethod("TSconnect",   signature(q="TSOraConnection", dbname="missing"),
   definition=function(q, dbname, ...) {
        con <- q
	dbname <-q@dbname
	if(0 == length(dbListTables(con))){
	  dbDisconnect(con)
          stop("Database ",dbname," has no tables.")
	  }
	if(!dbExistsTable(con, "Meta")){
	  dbDisconnect(con)
          stop("Database ",dbname," does not appear to be a TS database.")
	  }
	new("TSOraConnection" , con, dbname=dbname, 
  	       hasVintages=dbExistsTable(con, "vintageAlias"), 
  	       hasPanels  =dbExistsTable(con, "panels")) 
	})

setMethod("TSput",   signature(x="ANY", serIDs="character", con="TSOraConnection"),
   definition= function(x, serIDs, con=getOption("TSconnection"), Table=NULL, 
       TSdescription.=TSdescription(x), TSdoc.=TSdoc(x), TSlabel.=TSlabel(x),
        TSsource.=TSsource(x),  
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
    TSputSQL(x, serIDs, con, Table=Table, 
       TSdescription.=TSdescription., TSdoc.=TSdoc., TSlabel.=TSlabel.,
        TSsource.=TSsource.,
       vintage=vintage, panel=panel) )

setMethod("TSget",   signature(serIDs="character", con="TSOraConnection"),
   definition= function(serIDs, con=getOption("TSconnection"), 
       TSrepresentation=options()$TSrepresentation,
       tf=NULL, start=tfstart(tf), end=tfend(tf), names=NULL, 
       TSdescription=FALSE, TSdoc=FALSE, TSlabel=FALSE, TSsource=TRUE,
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
    TSgetSQL(serIDs, con, TSrepresentation=TSrepresentation,
       tf=tf, start=start, end=end, names=names, 
       TSdescription=TSdescription, TSdoc=TSdoc, TSlabel=TSlabel,
         TSsource=TSsource,
       vintage=vintage, panel=panel) )

setMethod("TSdates",    signature(serIDs="character", con="TSOraConnection"),
   definition= function(serIDs, con=getOption("TSconnection"),  
       vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
     TSdatesSQL(serIDs, con, vintage=vintage, panel=panel) )


setMethod("TSdescription",   signature(x="character", con="TSOraConnection"),
   definition= function(x, con=getOption("TSconnection"), ...)
        TSdescriptionSQL(x=x, con=con) )

setMethod("TSdoc",   signature(x="character", con="TSOraConnection"),
   definition= function(x, con=getOption("TSconnection"), ...)
        TSdocSQL(x=x, con=con) )

setMethod("TSlabel",   signature(x="character", con="TSOraConnection"),
   definition= function(x, con=getOption("TSconnection"), ...)
        TSlabelSQL(x=x, con=con) )

setMethod("TSsource",   signature(x="character", con="TSOraConnection"),
   definition= function(x, con=getOption("TSconnection"), ...)
        TSsourceSQL(x=x, con=con) )

setMethod("TSdelete", 
   signature(serIDs="character", con="TSOraConnection", vintage="ANY", panel="ANY"),
   definition= function(serIDs, con=getOption("TSconnection"),  
   vintage=getOption("TSvintage"), panel=getOption("TSpanel"), ...)
  TSdeleteSQL(serIDs=serIDs, con=con, vintage=vintage, panel=panel) )

setMethod("TSvintages", 
   signature(con="TSOraConnection"),
   definition=function(con) {
     if(!con@hasVintages) NULL else   
     sort(dbGetQuery(con,"SELECT  DISTINCT(vintage) FROM  vintages;" )$vintage)
     } )

setMethod("dropTStable", 
   signature(con="OraConnection", Table="character", yesIknowWhatIamDoing="ANY"),
   definition= function(con=NULL, Table, yesIknowWhatIamDoing=FALSE){
    if((!is.logical(yesIknowWhatIamDoing)) || !yesIknowWhatIamDoing)
      stop("See ?dropTStable! You need to know that you may be doing serious damage.")
    if(dbExistsTable(con, Table)) dbRemoveTable(con, Table)
    return(TRUE)
    } )
