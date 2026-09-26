# 验证记录（2026-09-26）

- R 分析：`Rscript run.R` 通过，输出 `n=32; R2=0.826785; wt=-3.877831; hp=-0.031773`。
- 自动构建：`Rscript build_papers.R` 通过，依次更新 R 输出并编译英文、中文论文，最终显示 `PAPERS_OK`。
- 英文论文：IMS/Annals of Statistics 风格，XeLaTeX + BibTeX 编译为 2 页 PDF；图、表、结果宏和作者—年份引用均存在。
- 中文论文：同一 IMS 结构加 `ctex`，XeLaTeX + BibTeX 编译为 2 页 PDF；中文、图、表、结果宏和参考文献均存在。
- 相对路径：两个 `main.tex` 都通过 `../../../outputs/` 读取 R 生成文件，不含个人绝对路径。
- 视觉检查：已将两篇 PDF 的首页渲染为 PNG 检查；标题、正文、插图和页脚没有裁切或重叠。第二页经文本抽取确认含完整系数表和两条参考文献。
- Bookdown：`Rscript publish.R` 成功生成 HTML；附录标题、统一构建命令和 arXiv:2412.06766 来源均出现在 `docs/appendix-positron.html`。
- 环境边界：以上验证在命令行完成；没有连接或测试用户的 Positron/DeepSeek 账户，也没有读取任何 API Key。
