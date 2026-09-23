# 中文统计论文模板（作者—年份引用）

arXiv 没有统一的中文模板。本目录采用 `ctexart + natbib + plainnat`：中文排版用 XeLaTeX，统计论文常见的作者—年份引用用 BibTeX。arXiv:2412.19437 的源码可作为中文兼容设置参考，但其中的 `deepseek.cls` 是定制类，不适合直接当作通用模板。正式投稿时必须换成目标期刊的 `.cls`、`.bst` 和参考文献规范。

```sh
xelatex -interaction=nonstopmode -halt-on-error main.tex
bibtex main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

示例使用 `\citet{gelman2020}` 和 `\citep{wickham2014}`；`references.bib` 可直接替换为自己的统计文献库。
