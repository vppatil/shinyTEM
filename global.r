library(shiny)
library(ncdf)
library(tcltk) #should ship with base R.

cat("select the nc file you want to work with: ")
filename<-tk_choose.files()

out<-open.ncdf(as.character(filename))
varnames<-as.vector(names(out$var))
dimnames<-as.vector(names(out$dim))
dimlen<-as.vector(sapply(out$dim,function(x) return(x$len)))
dim.df<-data.frame(dimnames=dimnames,dimlen=dimlen)
dim.df.notstep<-dim.df[dimnames !='tstep',]
ndim<-dim(dim.df.notstep)[1]
dat<-data.frame(YEAR=as.numeric(get.var.ncdf(out,'YEAR')))#extract year variable
