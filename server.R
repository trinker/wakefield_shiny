library(shiny)
library(wakefield)


# helpful examples here: http://shiny.rstudio.com/gallery/


# Define server logic required to summarize and view the
# selected dataset
shinyServer(function(input, output) {

  # This part creates the data
  # reactive function listens for changes in the 'input'
  # in this case you have 2 variables attached to input, obs and in1
  datasetInput <- reactive({
    eval(parse(text=sprintf("r_na(wakefield::r_data_frame(n = %s, %s), prob=%s)", input$obs, paste(input$in1, collapse = ", "), input$missing)))
  })

  # Generate a summary of the dataset to view
  # it is sent to ui
  # current ui is not displaying this, so I'm not calculating the summary
#   output$summary <- renderPrint({
#     summary(datasetInput())
#   })

  # this renders a table view
  # can be called in ui via
  # tableOutput("view")
    output$view <- renderTable({
      # this is the function you created above
      datasetInput()
    })

    # this chunk is from http://shiny.rstudio.com/gallery/download-file.html
    output$downloadData <- downloadHandler(

      # This function returns a string which tells the client
      # browser what name to use when saving the file.
      filename = function() {
        # hard-coded wakefield, but in gallery example,
        # you can change the name thru input var
        paste("wakefield", input$filetype, sep = ".")
      },

      # This function should write data to a file given to it by
      # the argument 'file'.
      content = function(file) {
        sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")

        # Write to a file specified by the 'file' argument
        write.table(datasetInput(), file, sep = sep,
                    row.names = FALSE)
      }
    )


    # this funciton creates a DT::DataTable view
    # table lets you sort and filter in webpage
#     output$mytable1 <- renderDataTable({
#       datasetInput()
#     })
})
