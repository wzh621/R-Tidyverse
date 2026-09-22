# 验证记录（2026-09-22）

- 示例：`Rscript run.R` 通过，n=32，R²=0.826785，wt=-3.877831，hp=-0.031773。
- 包：`R CMD build workflowdemo` 与 `R CMD check --no-manual workflowdemo_0.1.0.tar.gz` 通过，最终 Status: OK；日志见 outputs/reports/package-check.log。未执行手册 PDF 检查。
- 论文：paper 目录内 `pdflatex -interaction=nonstopmode -halt-on-error main.tex` 通过，生成 2 页 main.pdf，已抽查两页。
- 讲义：整本 HTML 与 PDF 构建完成；HTML 新增附录 H、无重复锚点、三张本地图片路径有效，所有附录 R 代码块通过语法解析。
- 讲义 PDF：最初生成文件无法读取；使用生成的 TeX 在临时目录重新运行 XeLaTeX 三遍，确认 256 页文件可读取、交叉引用稳定，抽查第 245、250 页后放回 book/_book。保留既有全书 PDF 样式和编号格式。
- 图像：两张官方 Positron 截图，来源见 book/images/positron/sources.md；一张讲义用本例生成图；另有项目诊断图 PNG/PDF。
- 限制：运行通过 Rscript/命令行完成，未验证本机 Positron 的 AI 账户连接。浏览器安全策略阻止 file:// 页面，因此 HTML 只完成构建与静态检查，未完成浏览器视觉检查。当前论文是教学 article 模板，未提供真实期刊模板。
