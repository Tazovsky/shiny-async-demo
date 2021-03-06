if (!require(parallel))
  install.packages("parallel")

if (!require("future"))
  install.packages(future)

# create cluster
cl <- parallel::makeCluster(1L)
plan(cluster, workers = cl)

server <- function(input, output) {
  observeEvent(input$run, {
    
    iteration <- as.numeric(input$iteration)
    path <- input$path
    
    future({
      # simple function to write to file
      writeLog <- function(n, path) {
        
        if (exists(path))
          file.remove(path)
        
        # some example value to write to file
        for (i in 1:n) {
          cat("#", i, "-",  as.character(Sys.time()), "\n", file = path, append = TRUE)
          Sys.sleep(1)
        }
      }
      writeLog(iteration, path)
    }, globals = c("iteration", "path")) # we want to export those variables to future environment
  })
}
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      tags$div("This app writes to file in cluster which means it is computed in parallel to this session. 
               NOTICE thah app will execute even when app is closed.")
      , br()
      , shiny::textInput("path", "Path to log file", value = file.path(getwd(), "future.log"))
      , shiny::textInput("iteration", "Iteration number", value = 60)    
      ),
    mainPanel(
      br()
      , actionButton("run", "Run future")
    )
  )
)
shinyApp(ui = ui, server = server)
