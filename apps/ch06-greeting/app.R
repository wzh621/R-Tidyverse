library(shiny)

# 教材图 6.34：输入姓名后，由 server 生成问候语。
ui <- fluidPage(
  textInput("name", "请输入您的姓名："),
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("您好 ", input$name, "！")
  })
}

shinyApp(ui = ui, server = server)
