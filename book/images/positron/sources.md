# Positron 附录图片与配置来源

核验与下载日期：2026-09-22。以下图片来自 Posit 官方文档，为官方示例界面，不代表本机实际运行截图；截图中的 R 版本是示例，不是课程的固定版本要求。图片已下载到本地，章节不依赖远程图片。

| 本地文件 | 官方页面 | 原图网址 | 用途 |
|---|---|---|---|
| `install/positron-interface-official.jpeg` | https://positron.posit.co/layout.html | https://positron.posit.co/images/user-interface-for-rstudio-migration.jpeg | 对照 Activity Bar、Explorer、Editor、Console、Variables/Plots 等界面区域 |
| `install/positron-r-interpreter-official.png` | https://positron.posit.co/managing-interpreters.html | https://positron.posit.co/images/active-interpreter-session.png | 红框标出 Interpreter picker；解释当前 R Console session |

图片权利归 Posit Software, PBC 等原权利人所有；保留来源用于教学引用，不声明自有版权。

## 已核验的版本敏感事实

- https://positron.posit.co/download.html ：下载页当前安装包为 2026.09.1-2；macOS 11+，区分 Apple Silicon / Intel；Windows x64 适用 Windows 10+、ARM64 适用 Windows 11。R 用户需另装 R 4.2 或更高版本。Windows 开发包需要时另装 Rtools，Positron 不捆绑 Rtools。
- https://positron.posit.co/r-installations.html ：通常自动发现 R；发现失败可在 R Advanced 设置中指定 `positron.r.customBinaries`（绝对路径）或 `positron.r.customRootFolders`。不要把每个设置都列为初学者必做步骤。
- https://positron.posit.co/managing-interpreters.html ：Interpreter picker → New Console Session；命令 `Interpreter: Start New Console Session`、`Interpreter: Select Session`、`Interpreter: Restart Active Interpreter Session`。
- https://positron.posit.co/assistant-getting-started.html ：`Authentication: Configure Language Model Providers`；`View: Show Posit Assistant`。DeepSeek 为 Experimental。
- https://positron.posit.co/assistant-providers.html ：DeepSeek 支持 API Key 或 `DEEPSEEK_API_KEY` 环境变量。Provider 配置在 `~/.posit/ai/providers.json`，密钥和 tokens 单独保存，不在该 JSON 中。旧 `authentication.*`、`positron.assistant.provider.*` 设置已被弃用。自定义 provider 可选择 OpenAI Compatible / Anthropic / OpenAI；应按服务实际协议选择类型。
- https://api-docs.deepseek.com/ ：OpenAI 格式 Base URL 为 `https://api.deepseek.com`；模型名称会更新，应以平台和 Positron 当时实际模型列表为准，不固定旧名称。

## 图片证据边界

本次官方 AI getting-started/providers 页面没有提供 DeepSeek 密钥对话框截图，因此不制作冒充真实界面的图片。章节可以使用明确标为“操作流程示意图”的自制流程图，并给出准确命令、字段说明；不能把示意图称为实机截图。API Key 由学生自己在安全输入框填写，不进入讲义、截图或 Git。

## 本项目生成图

`project/observed-fitted.png` 来自 `examples/positron-workflow/outputs/figures/observed-fitted.png`，由示例入口 `run.R` 于 2026-09-22 生成，使用 R 内置 mtcars 数据；它是实际统计输出，不是软件截图。更新示例后应同步此讲义副本。
