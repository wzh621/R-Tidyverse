library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)

# Shinylive 不能直接读取课程目录外的 RData 文件，因而加载由教材
# ecostats.rda 原样转换得到的 CSV；变量、观测和分析方法保持不变。
ecostats <- read.csv("ecostats.csv", check.names = FALSE)
countries <- unique(ecostats$Region)

ui <- fluidPage(
  titlePanel("交互探索 ecostats 数据"),
  sidebarLayout(
    sidebarPanel(selectInput(
      "name", "选择地区：", choices = countries, selected = "黑龙江"
    )),
    mainPanel(tabsetPanel(
      tabPanel("人均 GDP 图", plotlyOutput("eco_plot")),
      tabPanel("数据表", dataTableOutput("eco_data"))
    ))
  )
)

server <- function(input, output) {
  selected <- reactive({
    # 每次地区改变时，只保留相应观测。
    ecostats |> filter(Region == input$name)
  })

  output$eco_plot <- renderPlotly({
    # 绘制当前地区的人均 GDP 时间趋势。
    p <- ggplot(selected(), aes(Year, gdpPercap)) +
      geom_line(color = "red", linewidth = 1.2) +
      labs(
        title = paste0(input$name, "人均 GDP 变化趋势"),
        x = "年份", y = "人均 GDP"
      )
    ggplotly(p)
  })

  output$eco_data <- renderDataTable({
    # 建立带导出按钮的交互表格。
    datatable(
      selected(), extensions = "Buttons",
      caption = paste0(input$name, "数据"),
      options = list(
        dom = "Bfrtip",
        buttons = c("copy", "csv", "excel", "pdf", "print")
      )
    )
  })
}

shinyApp(ui = ui, server = server)
