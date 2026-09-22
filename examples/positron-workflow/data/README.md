# 数据来源与单位

示例直接读取 R 自带的 `datasets::mtcars`，不需要下载，也不要求复制一份 CSV。可在 R 中执行 `help("mtcars", package = "datasets")` 查阅随当前 R 安装提供的官方说明。

数据来自 1974 年 *Motor Trend* 美国杂志，包含 32 辆 1973–1974 年车型的油耗与 10 项设计/性能指标。R 帮助页列出的文献为 Henderson and Velleman (1981), Building multiple regression models interactively, *Biometrics*, 37, 391–411。该文献说明可查数据背景，本示例没有独立核验原杂志。

本模型只使用 `mpg`（每美制加仑英里数）、`wt`（重量，千磅）和 `hp`（总马力）。车型名保存在行名中。`wt` 的系数对应增加 1000 磅，不能误写成每增加 1 磅。

`R/analysis.R` 将内置数据读入内存并验证所需列，不修改 R 内置数据，不执行缺失值填补或静默删除。分析快照存入 `outputs/results/analysis.rds`，输出与输入分开管理。换用用户 CSV 时，应将只读原始文件放在本目录，记录来源、获取日期、许可和数据字典，在独立脚本中生成清洗后的数据；不要覆盖原始文件。
