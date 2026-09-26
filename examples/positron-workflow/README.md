# R + AI 助手 + LaTeX 自动更新示例

这个项目演示一条完整但精简的统计工作流：R 计算结果并生成图、表和数值宏；英文和中文 LaTeX 模板通过相对路径读取这些文件。修改 R 代码后重新构建，两篇论文同步更新。

## 一次运行全部流程

在 Positron 中打开本目录，在 Terminal 运行：

```sh
Rscript build_papers.R
```

脚本依次运行 `run.R`、英文 XeLaTeX/BibTeX 和中文 XeLaTeX/BibTeX。成功时显示 `WORKFLOW_OK` 和 `PAPERS_OK`。

只运行 R 分析时，在 R Console 执行：

```r
source("run.R")
```

## R 生成、LaTeX 引用

| R 生成文件 | LaTeX 调用方式 |
|---|---|
| `outputs/figures/observed-fitted.pdf` | `\includegraphics{../../../outputs/figures/observed-fitted.pdf}` |
| `outputs/tables/coefficients.tex` | `\input{../../../outputs/tables/coefficients.tex}` |
| `outputs/results/numbers.tex` | `\input{../../../outputs/results/numbers.tex}` |

全部使用相对路径，没有个人电脑的绝对路径。

## 统计论文模板

- `paper/templates/arxiv-english/`：英文 IMS/Annals of Statistics 风格。
- `paper/templates/arxiv-chinese/`：相同结构的中文版本，使用 `ctex`。
- 两个模板都使用 `references.bib` 和作者—年份引用。

`imsart.cls`、`imsart.sty` 和 `imsart-nameyear.bst` 取自 arXiv:2412.06766 的源码。该论文已录用到 *The Annals of Statistics*。上游模板文件保持原样，文件头声明采用 LaTeX Project Public License。

生成的论文位于：

```text
paper/templates/arxiv-english/main.pdf
paper/templates/arxiv-chinese/main.pdf
```

## 验证自动更新

在项目副本中修改 `R/export.R` 的图形颜色或标题，再运行 `Rscript build_papers.R`。中英文 PDF 中的图片应同时改变。修改模型后，`coefficients.tex`、`numbers.tex` 和两篇 PDF 中的结果也应同步改变。

## 文件职责

- `R/analysis.R`：检查数据并拟合 `mpg ~ wt + hp`。
- `R/export.R`：生成 PNG/PDF 图、CSV/LaTeX 表格、RDS 和数值宏。
- `run.R`：统一运行 R 分析。
- `build_papers.R`：统一更新 R 输出并编译中英文论文。
- `outputs/`：全部可重新生成的结果。
- `paper/templates/`：中英文统计论文源文件。

本例只用于工作流教学。正式统计研究仍需检查模型假设、数据质量和推断边界；正式投稿时应换成目标期刊当前提供的模板。
