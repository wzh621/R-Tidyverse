required <- c("bookdown", "rmarkdown", "knitr")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing)) {
  stop("缺少公开版编译所需 R 包：", paste(missing, collapse = ", "))
}

publish_dir <- normalizePath("docs", mustWork = FALSE)
if (dir.exists(publish_dir)) {
  unlink(publish_dir, recursive = TRUE, force = TRUE)
}
dir.create(publish_dir, recursive = TRUE, showWarnings = FALSE)

message("编译公开版 bookdown（仅 HTML，不生成或发布 PDF）……")
local({
  previous_dir <- setwd("book")
  on.exit(setwd(previous_dir), add = TRUE)
  bookdown::render_book(
    "index.Rmd",
    output_format = "bookdown::gitbook",
    output_dir = "../docs",
    output_yaml = "_output-public.yml"
  )
})

file.create(file.path(publish_dir, ".nojekyll"))

published_files <- list.files(publish_dir, recursive = TRUE, all.files = TRUE)
pdf_files <- published_files[grepl("\\.pdf$", published_files, ignore.case = TRUE)]
if (length(pdf_files)) {
  stop("公开目录中发现不应上传的 PDF：", paste(pdf_files, collapse = ", "))
}

html_files <- list.files(
  publish_dir,
  pattern = "\\.html$",
  recursive = TRUE,
  full.names = TRUE
)
html_text <- paste(
  unlist(lapply(html_files, readLines, warn = FALSE, encoding = "UTF-8")),
  collapse = "\n"
)
if (grepl('"download"\\s*:\\s*\\[[^]]+\\]', html_text, perl = TRUE)) {
  stop("公开版 HTML 仍包含下载文件配置，请检查 _output-public.yml。")
}

message("公开版已生成：", file.path(publish_dir, "index.html"))
