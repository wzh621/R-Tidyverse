#!/bin/sh
set -eu
out_dir=$(dirname "$0")
archive="$out_dir/aos-statistics-eprint.tar.gz"
printf '%s\n' '下载 arXiv:2412.06766 源码，用于核对 IMS/Annals of Statistics 模板来源。'
if [ -e "$archive" ]; then
  printf '%s\n' "文件已存在，不覆盖：$archive"
  exit 1
fi
curl -L https://export.arxiv.org/e-print/2412.06766 -o "$archive"
printf '%s\n' '已下载。请解压到临时目录核对 imsart 文件；不要提交完整论文源码包。'
