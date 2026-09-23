#!/bin/sh
set -eu
out_dir=$(dirname "$0")
printf '%s\n' '下载 arXiv 源码仅用于核对模板来源；不会覆盖已有模板。'
curl -L https://export.arxiv.org/e-print/1706.03762 -o "$out_dir/attention-eprint.tar.gz"
curl -L https://export.arxiv.org/e-print/2412.19437 -o "$out_dir/deepseek-eprint.tar.gz"
printf '%s\n' '已下载：请解压到临时目录并核对 .sty/.cls，不要把完整源码包提交到课程仓库。'
