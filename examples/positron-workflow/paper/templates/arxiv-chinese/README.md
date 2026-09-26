# 中文 IMS 统计论文模板

本模板沿用英文版的 IMS/Annals of Statistics 结构，并增加 `ctex` 中文支持。
`imsart.cls`、`imsart.sty` 和 `imsart-nameyear.bst` 来自 arXiv:2412.06766
的公开源码，保持原样；文件头声明采用 LaTeX Project Public License。

在项目根目录运行：

```sh
Rscript build_papers.R
```

模板通过相对路径读取 R 生成的图片、表格和结果宏，并使用
`references.bib` 与作者—年份引用。中文使用 TeX Live 自带的 Fandol 字体，
需要 XeLaTeX。正式投稿前，应换成目标期刊当前提供的模板和作者指南。
