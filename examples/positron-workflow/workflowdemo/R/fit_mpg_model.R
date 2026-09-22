# mpg 为每加仑英里数，wt 为千磅，hp 为马力。
# 不静默删除缺失值：输入不满足教学数据契约时立即停止。
fit_mpg_model <- function(data) {
  required <- c("mpg", "wt", "hp")
  if (!is.data.frame(data) || !all(required %in% names(data)))
    stop("data must contain mpg, wt, and hp columns")
  if (nrow(data) < 4L || !all(vapply(data[required], is.numeric, logical(1))))
    stop("At least four rows and numeric mpg, wt, hp are required")
  if (!all(vapply(data[required], function(x) all(is.finite(x)), logical(1))))
    stop("Missing or non-finite values are not allowed")
  fit <- stats::lm(mpg ~ wt + hp, data = data, na.action = stats::na.fail)
  if (fit$rank < 3L) stop("The design matrix is rank deficient")
  fit
}
