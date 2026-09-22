# 在 Positron 中先打开本文件所在目录为项目，再执行 source("run.R")。
# 命令行支持从任意目录执行 Rscript /absolute/path/to/run.R。
args <- commandArgs(trailingOnly = FALSE)
script <- grep("^--file=", args, value = TRUE)
root <- if (length(script)) dirname(normalizePath(sub("^--file=", "", script[1]))) else getwd()
if (!file.exists(file.path(root, "R", "analysis.R")))
  stop("Open the positron-workflow project directory before source('run.R')")
for (d in c("figures", "tables", "results", "reports"))
  dir.create(file.path(root, "outputs", d), recursive = TRUE, showWarnings = FALSE)
source(file.path(root, "R", "analysis.R"), local = TRUE)
source(file.path(root, "R", "export.R"), local = TRUE)
cat(sprintf("WORKFLOW_OK: n=%d; R2=%.6f; wt=%.6f; hp=%.6f\n", nobs(fit),
            summary(fit)$r.squared, coef(fit)["wt"], coef(fit)["hp"]))
