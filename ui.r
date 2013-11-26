library(shiny)
library(ncdf)

out<-open.ncdf('cmtbgc_yly-eq.nc')

varnames=sapply(out$var,function(x) return(x$name))
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("DVM-DOS-TEM output"),

  
  sidebarPanel(
    
    selectInput("pft", "PFT:",1:10),
    selectInput("vegpart","VEGPART:",1:3),
    selectInput("soillayer","Soil Layer:",1:23),
    sliderInput("xrange","Years to plot:",
                min=0,max=2000,value=c(0,2000)),
    
    selectInput("variable", "Variable:",
                choices=varnames,selected='GPP'),
    selectInput("variable2", "Variable 2:",choices=varnames,selected='NPP'),
               selectInput("variable3", "Variable 3:",choices=varnames,selected='VEGCSUM'),
    selectInput("variable4", "Variable 4:",choices=varnames,selected='AVLNSUM'),
    selectInput("variable5", "Variable 5:",choices=varnames,selected='VEGNSUM'),
    selectInput("variable6", "Variable 6:",choices=varnames,selected='SOMCSHLW')
  ),
  


  mainPanel(
    h3(textOutput("caption")),

	plotOutput("tsPlot",height="700px")
	)
))
