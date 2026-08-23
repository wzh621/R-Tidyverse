# 《R 语言编程：基于 tidyverse》课程资源

作者：王芝皓  
单位：统计与数据科学学院

本目录以《R 语言编程：基于 tidyverse》（张敬信，人民邮电出版社，2023）为主教材，结合配套课件、源代码、实验材料与教学大纲组织。

## 目录

- `book/`：bookdown 讲义工程；第 0、1 章已完成，其余章节已建立与教材一致的文件框架。
- `slides/`：R Markdown / xaringan 幻灯片工程；第 0、1 章已完成。
- `assets/`：共享截图与素材。
- `MATERIALS.md`：教材、30 讲课件、源代码、实验与数据资源的课程映射。
- `build.R`：依次编译 HTML 讲义、LaTeX PDF 讲义与幻灯片。
- `publish.R`：生成可公开上传的纯 HTML 讲义到 `docs/`，不生成或发布 PDF。

## 编译

在 Positron 中打开 `course` 文件夹，启动 R 会话后运行：

```r
source("build.R")
```

也可分别运行：

```r
local({
  old <- setwd("book")
  on.exit(setwd(old), add = TRUE)
  bookdown::render_book("index.Rmd", output_format = "all", output_dir = "_book")
})
rmarkdown::render("slides/00-intro.Rmd")
rmarkdown::render("slides/01-basic-syntax.Rmd")
```

PDF 版本使用 XeLaTeX 与 `ctexbook` 生成。编译环境需要能够调用 `xelatex`；在当前 Positron 环境中已配置并验证成功。

## 公开发布

- GitHub：https://github.com/wzh621/R-Tidyverse
- Gitee 镜像：https://gitee.com/wangzh1109/R-Tidyverse
- 在线讲义：https://wzh621.github.io/R-Tidyverse/

公开仓库使用单独的发布入口：

```r
source("publish.R")
```

生成的 `docs/` 可由 GitHub Pages 从 `main` 分支的 `/docs` 目录发布。公开版仅包含 HTML，不包含 PDF 文件，也不显示 PDF 下载入口。本地 `build.R` 的 PDF 工作流不受影响。

生成文件位于：

- `book/_book/index.html`
- `book/_book/R语言编程讲义.pdf`
- `slides/00-intro.html`
- `slides/01-basic-syntax.html`
- `docs/index.html`（公开发布版）

## 说明

- 讲义同时输出 `bookdown::gitbook` 与 `bookdown::pdf_book`。HTML 页面顶部的下载按钮可直接下载当前编译生成的 PDF。
- 幻灯片使用 `xaringan::moon_reader`，方向键翻页，按 `F` 全屏，按 `P` 查看演讲者备注。
- DeepSeek API Key 只应通过 Positron 的认证界面或系统环境变量配置，不应写入本项目或提交到版本控制。
