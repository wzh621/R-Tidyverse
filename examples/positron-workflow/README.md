# Positron 全流程配套示例

这是教学项目，不是完成有效性审查的汽车研究。仅需 R 自带包；不调用 AI、不需要 API Key。

## 在 Positron 运行

打开本目录（包含 run.R）作为项目，选择 R 解释器，在 R Console 执行：

```r
source("run.R")
```

或在本目录的 Terminal 运行 `Rscript run.R`。命令行也支持从任何目录运行本文件的绝对路径。无随机算法，无需设置随机种子。实际结果与环境写入工作报告；重复执行会更新 outputs 中同名生成文件。

## 文件与结果

- `R/analysis.R`：读取内置 mtcars、校验数据并拟合 `mpg ~ wt + hp`。
- `R/export.R`：将同一模型输出为 PNG/PDF、CSV、RDS、LaTeX 表和数字宏、Markdown 工作说明。
- `outputs/figures/observed-fitted.png` / `.pdf`：屏幕与论文图。
- `outputs/figures/diagnostics.png` / `.pdf`：残差对拟合值、正态 Q-Q、尺度位置和残差对杠杆值四联诊断图；须人工解释异常点和模式。
- `outputs/tables/coefficients.csv` / `.tex`：机器可读结果和论文表格。
- `outputs/results/analysis.rds`：数据、模型、系数表；用 `readRDS()` 读取。
- `outputs/results/numbers.tex`：论文引用的实际数字；禁止人工改写产生第二份结果。
- `outputs/reports/work-report.md`：目的、方法、结果、解释、局限、复现和运行环境。
- `workflowdemo/`：最小独立 R 包，含 DESCRIPTION、NAMESPACE、函数、Rd 和边界测试。
- `paper/main.tex`：可编译的通用英文教学模板，不冒充任何期刊的官方模板。

## 构建和检查 R 包

在本目录执行（无需安装第三方依赖；`R CMD check` 会在临时检查库内安装本包）：

```sh
R CMD build workflowdemo
R CMD check --no-manual workflowdemo_0.1.0.tar.gz
```

交互式试用包可自行执行 `install.packages("workflowdemo_0.1.0.tar.gz", repos = NULL, type = "source")`，然后 `library(workflowdemo)` 和 `fit_mpg_model(mtcars)`。主流程直接加载包源码，因此无需先安装。

## 编译论文

需要本机已有 LaTeX（如 TinyTeX、MacTeX 或 TeX Live）。从本目录执行：

```sh
cd paper
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

图表和数字路径相对于 `paper/`，必须在该目录编译。输出为 `paper/main.pdf`。R 运行不依赖 LaTeX；若未安装编译器，可先检查已生成的 `.tex` 文件。

## 接入用户已有论文模板

先复制原模板到新的工作目录，保留原始 `.cls`、`.sty`、参考文献配置和章节命令。根据新目录调整路径，在导言区加入 `\input{../outputs/results/numbers.tex}`，在模板规定的 table 环境中加入 `\input{../outputs/tables/coefficients.tex}`，在 figure 环境中加入 `\includegraphics{../outputs/figures/observed-fitted.pdf}`。复用模板自己的标题、作者、图表和参考文献规范，不以本例的 `article` 类替换它。确保模板已加载 graphicx。含中文的原模板按其指定引擎（常见为 XeLaTeX）编译。

这里未提供用户的真实模板，因此只验证通用教学模板。正式写作前还需依据真实数据补齐研究背景、文献、诊断与模型局限，不能让 AI 编造来源或显著性。
