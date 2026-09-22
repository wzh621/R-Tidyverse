library(workflowdemo)
fit <- fit_mpg_model(datasets::mtcars)
stopifnot(inherits(fit, "lm"), stats::nobs(fit) == 32L,
          abs(unname(stats::coef(fit)["wt"]) - (-3.877830742)) < 1e-8)
bad <- datasets::mtcars
bad$mpg[1] <- NA_real_
stopifnot(inherits(try(fit_mpg_model(bad), silent = TRUE), "try-error"))
stopifnot(inherits(try(fit_mpg_model(data.frame(x = 1:5)), silent = TRUE), "try-error"))
rank_bad <- datasets::mtcars
rank_bad$hp <- rank_bad$wt
stopifnot(inherits(try(fit_mpg_model(rank_bad), silent = TRUE), "try-error"))
