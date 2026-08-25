options(repos = c(CRAN = "https://mirrors.bfsu.edu.cn/CRAN/"))

required <- c("bookdown", "rmarkdown", "knitr", "xaringan")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing)) {
  stop(
    "缺少编译所需 R 包：", paste(missing, collapse = ", "),
    "\n请先运行 install.packages(c(",
    paste(sprintf('"%s"', missing), collapse = ", "), "))"
  )
}

message("[1/2] 编译 bookdown 讲义（HTML + LaTeX PDF）……")
local({
  previous_dir <- setwd("book")
  on.exit(setwd(previous_dir), add = TRUE)
  bookdown::render_book(
    "index.Rmd",
    output_format = "all",
    output_dir = "_book"
  )
})

message("[2/2] 编译 R Markdown 幻灯片……")
slide_sources <- c(
  "slides/00-intro.Rmd",
  "slides/01-basic-syntax.Rmd",
  "slides/02-data-manipulation.Rmd",
  "slides/03-visualization-modeling.Rmd",
  "slides/04-applied-statistics.Rmd",
  "slides/05-eda.Rmd",
  "slides/06-communication.Rmd"
)

for (slide_source in slide_sources) {
  rmarkdown::render(
    slide_source,
    output_file = sub("\\.Rmd$", ".html", basename(slide_source)),
    envir = new.env(parent = globalenv())
  )
}

message("编译完成。")
