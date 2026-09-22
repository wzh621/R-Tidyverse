# 所有文件写到项目内部，重复运行仅更新本示例生成的 outputs。
write.csv(table, file.path(root, "outputs", "tables", "coefficients.csv"), row.names = FALSE)
saveRDS(list(data = data, model = fit, coefficients = table),
        file.path(root, "outputs", "results", "analysis.rds"))
plot_fit <- function() {
  plot(fitted(fit), data$mpg, pch = 19, col = "#2166AC",
       xlab = "Fitted fuel economy (mpg)", ylab = "Observed fuel economy (mpg)",
       main = "Teaching example: mtcars (n = 32)")
  abline(0, 1, lty = 2, col = "#B2182B")
}
# 将设备关闭放在 on.exit 中，作图报错也不会遗留打开的设备。
write_plot <- function(path, type) {
  if (type == "png") grDevices::png(path, width = 1600, height = 1100, res = 180)
  else grDevices::pdf(path, width = 7, height = 4.8)
  on.exit(grDevices::dev.off())
  plot_fit()
}
write_plot(file.path(root, "outputs", "figures", "observed-fitted.png"), "png")
write_plot(file.path(root, "outputs", "figures", "observed-fitted.pdf"), "pdf")
# 残差诊断用来发现需要进一步检查的信号，不是自动通过模型假设审查。
write_diagnostics <- function(path, type) {
  if (type == "png") grDevices::png(path, width = 1800, height = 1600, res = 180)
  else grDevices::pdf(path, width = 8, height = 7)
  on.exit(grDevices::dev.off())
  graphics::par(mfrow = c(2, 2), mar = c(4.5, 4.8, 3, 2.5))
  plot(fit, which = c(1, 2, 3, 5), id.n = 0)
}
write_diagnostics(file.path(root, "outputs", "figures", "diagnostics.png"), "png")
write_diagnostics(file.path(root, "outputs", "figures", "diagnostics.pdf"), "pdf")

# 本例变量名为固定安全标签；用户自定义文本需另行转义 LaTeX 特殊字符。
labels <- c("Intercept", "Weight (1000 lbs)", "Horsepower")
rows <- vapply(seq_len(nrow(table)), function(i)
  sprintf("%s & %.3f & %.3f & [%.3f, %.3f] & %s \\\\",
          labels[i], table$estimate[i], table$std_error[i],
          table$conf_low[i], table$conf_high[i],
          if (table$p_value[i] < 0.001) "$<0.001$" else sprintf("%.3f", table$p_value[i])),
  character(1))
writeLines(c("\\begin{tabular}{lrrrr}", "\\hline",
  "Term & Estimate & SE & 95\\% CI & $p$ \\\\", "\\hline", rows,
  "\\hline", "\\end{tabular}"), file.path(root, "outputs", "tables", "coefficients.tex"))
writeLines(c(sprintf("\\newcommand{\\SampleSize}{%d}", nobs(fit)),
             sprintf("\\newcommand{\\ModelRsquared}{%.3f}", summary(fit)$r.squared),
             sprintf("\\newcommand{\\WeightEstimate}{%.3f}", coef(fit)["wt"])),
           file.path(root, "outputs", "results", "numbers.tex"))
session_lines <- trimws(capture.output(sessionInfo()), which = "right")
report <- c("# 工作说明：mtcars 回归教学示例", "",
  "目的：演示从 R 分析到论文图表的文件流程；不将观察性回归解释为因果关系。", "",
  "数据：R 内置 datasets::mtcars，32 辆汽车；mpg 为每加仑英里数，wt 为千磅，hp 为马力。",
  "模型：mpg ~ wt + hp，普通最小二乘；置信区间和 p 值依赖线性模型假设。", "",
  sprintf("实际结果：n = %d，R² = %.6f，wt 系数 = %.6f，hp 系数 = %.6f。",
          nobs(fit), summary(fit)$r.squared, coef(fit)["wt"], coef(fit)["hp"]), "",
  "解释：在模型中控制 hp 后，wt 每增加 1 千磅，预测 mpg 平均减少约 3.878。",
  "局限：样本量小且非随机抽样；已生成残差、正态 Q-Q、尺度位置和杠杆值诊断图；诊断图仍需人工解读，未完成模型假设或外推有效性审查。", "",
  "复现：在示例项目根目录运行 Rscript run.R；检查终端 WORKFLOW_OK。",
  "生成图见 ../figures/observed-fitted.png；机器可读表见 ../tables/coefficients.csv。", "",
  "## 运行环境", "", "```", session_lines, "```")
writeLines(report, file.path(root, "outputs", "reports", "work-report.md"))
writeLines(session_lines, file.path(root, "outputs", "results", "session-info.txt"))
