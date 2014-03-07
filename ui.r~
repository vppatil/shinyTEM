library(shiny)
library(ncdf)

# Define UI for miles per gallon applications
shinyUI(pageWithSidebar(
  # Application title
  headerPanel("DVM-DOS-TEM output"),
  sidebarPanel(  
  conditionalPanel(
    condition= ndim>=1,   
    selectInput(as.character(dim.df.notstep$dimnames[1]),as.character(dim.df.notstep$dimnames[1]),if(ndim>=1){1:dim.df.notstep$dimlen[1]} else {0})),
   conditionalPanel(
     condition= ndim>=2,   
     selectInput(as.character(dim.df.notstep$dimnames[2]),as.character(dim.df.notstep$dimnames[2]),if(ndim>=2){1:dim.df.notstep$dimlen[2]} else {0})),
   conditionalPanel(
     condition= ndim>=3,  
     selectInput(as.character(dim.df.notstep$dimnames[3]),as.character(dim.df.notstep$dimnames[3]),if(ndim>=3){1:dim.df.notstep$dimlen[3]} else {0})),
    conditionalPanel(
     condition= ndim>=4,  
     selectInput(as.character(dim.df.notstep$dimnames[4]),as.character(dim.df.notstep$dimnames[4]),if(ndim>=4){1:dim.df.notstep$dimlen[4]} else {0})),
  conditionalPanel(
    condition= ndim>=5,  
    selectInput(as.character(dim.df.notstep$dimnames[5]),as.character(dim.df.notstep$dimnames[5]),if(ndim>=5){1:dim.df.notstep$dimlen[5]} else {0})),

    sliderInput("xrange","Years to plot:",
                min=0,max=2000,value=c(0,2000)),
    
    selectInput("variable1", "Variable 1:",choices=varnames,selected=varnames[1]),
    selectInput("variable2", "Variable 2:",choices=varnames,selected=varnames[2]),
    selectInput("variable3", "Variable 3:",choices=varnames,selected=varnames[3]),
    selectInput("variable4", "Variable 4:",choices=varnames,selected=varnames[4]),
    selectInput("variable5", "Variable 5:",choices=varnames,selected=varnames[5]),
    selectInput("variable6", "Variable 6:",choices=varnames,selected=varnames[6])
#   wellPanel(
#     p( downloadButton('pdf','save as PDF'),textInput('savename','file name','plot.pdf'))
#   )    
 ),
  
  mainPanel(
    h3(filename),
    plotOutput("tsPlot",height="700px")
  )
))
