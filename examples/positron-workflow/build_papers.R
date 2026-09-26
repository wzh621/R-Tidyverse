# 从任意目录调用本文件时，仍以本文件所在目录作为项目根目录。
args <- commandArgs(trailingOnly = FALSE)
script_arg <- grep("^--file=", args, value = TRUE)
project_root <- if (length(script_arg)) {
  dirname(normalizePath(sub("^--file=", "", script_arg[1])))
} else {
  normalizePath(getwd())
}

required_commands <- c("xelatex", "bibtex")
missing_commands <- required_commands[Sys.which(required_commands) == ""]
if (length(missing_commands)) {
  stop("缺少 LaTeX 命令：", paste(missing_commands, collapse = ", "),
       "。请先安装 TinyTeX、MacTeX 或 TeX Live。")
}

# 第一步：重新运行统计分析，更新 outputs 中的图、表和数值宏。
source(file.path(project_root, "run.R"), local = new.env(parent = globalenv()))

run_command <- function(directory, command, command_args) {
  old_directory <- setwd(directory)
  on.exit(setwd(old_directory), add = TRUE)
  status <- system2(command, command_args)
  if (!identical(status, 0L)) {
    stop(command, " 编译失败：", normalizePath(directory))
  }
}

compile_paper <- function(directory) {
  run_command(directory, "xelatex",
              c("-interaction=nonstopmode", "-halt-on-error", "main.tex"))
  run_command(directory, "bibtex", "main")
  run_command(directory, "xelatex",
              c("-interaction=nonstopmode", "-halt-on-error", "main.tex"))
  run_command(directory, "xelatex",
              c("-interaction=nonstopmode", "-halt-on-error", "main.tex"))
}

templates_root <- file.path(project_root, "paper", "templates")
compile_paper(file.path(templates_root, "arxiv-english"))
compile_paper(file.path(templates_root, "arxiv-chinese"))

cat("PAPERS_OK:\n",
    file.path(templates_root, "arxiv-english", "main.pdf"), "\n",
    file.path(templates_root, "arxiv-chinese", "main.pdf"), "\n", sep = "")
