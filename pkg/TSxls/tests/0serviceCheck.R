#not sure what to check here

service <- Sys.getenv("_R_CHECK_HAVE_PERLCSVXS_")

Sys.info()

if(identical(as.logical(service), TRUE)) {
   require("TSxls") 
   if( ! "XLSX" %in% gdata::xlsFormats()) stop("Perl libraries are not available." )
 }else {
   cat("Perl libraries not available. Skipping tests.\n")
   cat("_R_CHECK_HAVE_PERLCSVXS_ setting ", service, "\n")
   }
