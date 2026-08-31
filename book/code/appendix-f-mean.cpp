#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double meanC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for (int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total / n;
}

/*** R
# 固定随机种子，使两种均值函数处理完全相同的数据
set.seed(123)
x <- runif(1e5)

# 先核对两种函数的计算结果
mean(x)
meanC(x)

# 比较运行速度，并检查两种表达式的结果是否一致
bench::mark(mean(x), meanC(x), check = TRUE)[, 1:6]
*/
