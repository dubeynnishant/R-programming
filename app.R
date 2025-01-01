library(shiny)

# Define a simple food calorie database
calorie_data <- data.frame(
  food = c("Apple", "Banana", "Bread", "Chicken Breast", "Rice"),
  calories_per_100g = c(52, 89, 265, 165, 130)
)

# UI
ui <- fluidPage(
  titlePanel("Calories Counter"),
  sidebarLayout(
    sidebarPanel(
      selectInput("food", "Select Food:", choices = calorie_data$food),
      numericInput("quantity", "Quantity (in grams):", value = 100, min = 1),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      h4("Calories:"),
      verbatimTextOutput("result")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$calculate, {
    selected_food <- input$food
    quantity <- input$quantity
    calories_per_100g <- calorie_data$calories_per_100g[calorie_data$food == selected_food]
    total_calories <- (calories_per_100g / 100) * quantity
    
    output$result <- renderText({
      paste("Total calories for", quantity, "grams of", selected_food, "is:", total_calories, "kcal")
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)







