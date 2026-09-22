# 工作说明：mtcars 回归教学示例

目的：演示从 R 分析到论文图表的文件流程；不将观察性回归解释为因果关系。

数据：R 内置 datasets::mtcars，32 辆汽车；mpg 为每加仑英里数，wt 为千磅，hp 为马力。
模型：mpg ~ wt + hp，普通最小二乘；置信区间和 p 值依赖线性模型假设。

实际结果：n = 32，R² = 0.826785，wt 系数 = -3.877831，hp 系数 = -0.031773。

解释：在模型中控制 hp 后，wt 每增加 1 千磅，预测 mpg 平均减少约 3.878。
局限：样本量小且非随机抽样；已生成残差、正态 Q-Q、尺度位置和杠杆值诊断图；诊断图仍需人工解读，未完成模型假设或外推有效性审查。

复现：在示例项目根目录运行 Rscript run.R；检查终端 WORKFLOW_OK。
生成图见 ../figures/observed-fitted.png；机器可读表见 ../tables/coefficients.csv。

## 运行环境

```
R version 4.6.1 (2026-06-24)
Platform: aarch64-apple-darwin23
Running under: macOS Tahoe 26.7

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRblas.0.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1

locale:
[1] C.UTF-8/C.UTF-8/C.UTF-8/C/C.UTF-8/C.UTF-8

time zone: Asia/Shanghai
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

loaded via a namespace (and not attached):
[1] compiler_4.6.1
```
