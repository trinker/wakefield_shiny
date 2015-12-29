library(shiny)
library(wakefield)



shinyUI(fluidPage(
  titlePanel("Wakefield Data Simulator"),
  sidebarLayout(
    sidebarPanel(
            selectInput("in1", "Choose variables:",
                        choices = c("id", wakefield::variables()),
                        , multiple=TRUE, selectize=TRUE, selected=c("id", "age")) ,
            numericInput("obs", "Choose nrows:", 20) ,
        
          sliderInput("missing", "Percent Missing:", 0, 1, value = 0),
        
          radioButtons("filetype", "Choose file type:", choices = c("csv", "tsv")),
            downloadButton('downloadData', 'Download')
    ),

    #wellPanel(
     #   helpText(   a("Fork me on GitHub:",     href="https://github.com/trinker/wakefield")
    #),      
    mainPanel(

#       h4("Summary"),
#       verbatimTextOutput("summary"),
#
   # wellPanel(
       helpText("Visit the wakefield Project on GitHub: ",   a("https://github.com/trinker/wakefield",     href="https://github.com/trinker/wakefield")),
    #),
        

      h4("Observations"),
      tableOutput("view")#,


    )
  ))
)