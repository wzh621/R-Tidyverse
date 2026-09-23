# arXiv 统计论文示例模板（作者—年份引用）

arXiv 没有统一的统计学 `.cls`；统计论文常见做法是以 `article` 为基础，配合 `natbib` 的作者—年份引用和 `plainnat` 参考文献样式。本目录按这一 arXiv 统计投稿习惯组织，正文含方法、结果和可复现性段落，并提供 `references.bib`。它是教学模板，不代表任何期刊的最终投稿格式。

模板来源和下载记录：可用 `download_arxiv_templates.sh` 下载 arXiv 源码作对照；本模板保留 arXiv 通用 `article` 结构，并将统计写作需要的 `natbib`/BibTeX 加入其中。正式投稿时必须换成目标期刊提供的 `.cls`、`.bst` 和引用规范。

在项目根目录运行 `Rscript run.R` 后，从本目录执行：

```sh
xelatex -interaction=nonstopmode -halt-on-error main.tex
bibtex main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

`\citet{gelman2020}` 生成“Gelman等（2020）”，`\citep{wickham2014}` 生成“（Wickham, 2014）”。分析数字、表格和图形仍由 `outputs/` 自动生成。
