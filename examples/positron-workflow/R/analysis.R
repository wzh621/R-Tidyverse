# 从源码载入与 R 包导出完全相同的函数，不需要先安装包。
source(file.path(root, "workflowdemo", "R", "fit_mpg_model.R"), local = TRUE)
data <- datasets::mtcars
fit <- fit_mpg_model(data)
coefs <- as.data.frame(summary(fit)$coefficients)
ci <- stats::confint(fit)
table <- data.frame(term = rownames(coefs), estimate = coefs[[1]],
                    std_error = coefs[[2]], statistic = coefs[[3]],
                    p_value = coefs[[4]], conf_low = ci[, 1], conf_high = ci[, 2],
                    row.names = NULL)
stopifnot(nrow(data) == 32L, abs(unname(coef(fit)["wt"]) + 3.877830742) < 1e-8)
