library(shiny)
library(ncdf)

#function to extract and slice a variable by the specified dimensions


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  formulaText<-reactive({
    paste(input$variable,"~YEAR")
    
  })
  

  
  output$tsPlot<-renderPlot({
    out<-open.ncdf('cmtbgc_yly-eq.nc')#open connection
    var.list<-names(out$var)
    dat<-data.frame(YEAR=get.var.ncdf(out,'YEAR'))#extract year variable
    dim.names<-names(out$dim)
    dim.codes<-sapply(out$dim,function(x) return(x$id))
    dim.length<-sapply(out$dim,function(x) return(x$len))
    dim.df<-data.frame(dim.names,dim.codes,dim.length)
    
    variable.extraction<-function(out,variable){
      
      
      var1.name<-variable #get character string
      var1<-get.var.ncdf(out,var1.name)#read in data
      var1.dimlen<-dim(var1) #length of each dimension
      var1<-as.array(var1) #convert to array
      var1.dims<-out$var[[match(var1.name,var.list)]]$dimids#dimension ids
      var1.ndims<-out$var[[match(var1.name,var.list)]]$ndims#number of dimensions
      var1.dimnames<-dim.names[match(var1.dims,dim.codes)]#names of dimensions
      
      #next block of code- need to name all dimensions in array
      dimnames.list<-list()
      for(i in 1:var1.ndims)
      {dimnames.list[[i]]=c(1:dim(var1)[i])}
      dimnames(var1)<-dimnames.list
      
      var1.dimorder<-1:length(var1.dims)
      var1.dimorder<-var1.dimorder[order(var1.dims)]#permutation order for matrix
      
      
      tstep.dim<-grep('tstep',var1.dimnames)
      pft.dim<-grep('pft',var1.dimnames)
      vegpart.dim<-grep('vegpart',var1.dimnames)
      soillayer.dim<-grep('soillayer',var1.dimnames)
      
      if(var1.ndims>1) #put the dimensions in the order :tstep,pft,vegpart,soillayer
      {
        var1<-aperm(var1,var1.dimorder)
        if(var1.ndims==2)
        {
          dim.index<-ifelse(dim(var1)[2]==10,input$pft,ifelse(dim(var1[2])==3,input$vegpart,input$soillyr)) 
          var1<-var1[,dim.index]
        } else if(var1.ndims==3)
        {   
          dim.index2<-ifelse(dim(var1)[2]==10,input$pft,ifelse(dim(var1)[2]==3,input$vegpart,input$soillayer))
          dim.index3<-ifelse(dim(var1)[3]==10,input$pft,ifelse(dim(var1)[3]==3,input$vegpart,input$soillayer))
          var1<-var1[,dim.index2,dim.index3]
        }    
      }
      return(var1)
    }

    dat$var1<-variable.extraction(out,input$variable)
    dat$var2<-variable.extraction(out,input$variable2)
    dat$var3<-variable.extraction(out,input$variable3)
    dat$var4<-variable.extraction(out,input$variable4)
    dat$var5<-variable.extraction(out,input$variable5)
    dat$var6<-variable.extraction(out,input$variable6)
    
    dat<-dat[-c(1:101),]#removing the weird spin up period.
    
    
    par(mfrow = c(6,1),
        oma = c(4,0,0,0) + 0.1,
        mar = c(.1,4,0,0) + 0.1)
    plot(var1~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable,xlab='',xaxt='n',cex.lab=1.5)
    plot(var2~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable2,xlab='',xaxt='n',cex.lab=1.5)
    plot(var3~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable3,xlab='',xaxt='n',cex.lab=1.5)
    plot(var4~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable4,xlab='',xaxt='n',cex.lab=1.5)
    plot(var5~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable5,xlab='',xaxt='n',cex.lab=1.5)
    plot(var6~YEAR,data=dat,type='l',xlim=input$xrange,ylab=input$variable6,xlab='',cex.lab=1.5)
    title(xlab = "YEAR",cex.lab=1.5,
          outer = TRUE, line = 3,cex=1.5)
  })
})

