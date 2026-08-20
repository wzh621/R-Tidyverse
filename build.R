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
rmarkdown::render(
  "slides/00-intro.Rmd",
  output_file = "00-intro.html",
  envir = new.env(parent = globalenv())
)

message("编译完成。")
