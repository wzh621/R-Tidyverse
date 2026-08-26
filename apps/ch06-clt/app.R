library(shiny)
library(ggplot2)

# 教材图 6.36：通过改变分布和模拟参数观察中心极限定理。
ui <- fluidPage(
  titlePanel("演示中心极限定理"),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      selectInput("distr", "分布：", c("均匀", "二项", "泊松", "指数")),
      sliderInput("samples", "随机变量数：", 1, 100, 10),
      sliderInput("nsim", "模拟样本量：", 1000, 10000, 1000, step = 100),
      sliderInput("bins", "条形数：", 10, 100, 50)
    ),
    mainPanel(plotOutput("plot"))
  )
)

server <- function(input, output) {
  Xbar <- reactive({
    # 取得随机变量个数和模拟样本量。
    n <- input$samples
    m <- input$nsim

    # 按用户选择的分布生成 m × n 个随机数。
    xs <- switch(
      input$distr,
      "均匀" = runif(m * n, 0, 1),
      "二项" = rbinom(m * n, 10, 0.3),
      "泊松" = rpois(m * n, 5),
      "指数" = rexp(m * n, 1)
    )

    # 每 n 个随机变量求均值，得到 m 个样本均值。
    data.frame(x = rowMeans(matrix(xs, ncol = n)))
  })

  output$plot <- renderPlot({
    ggplot(Xbar(), aes(x)) +
      geom_histogram(
        alpha = 0.2, bins = input$bins,
        fill = "steelblue", color = "black"
      )
  })
}

shinyApp(ui = ui, server = server)
