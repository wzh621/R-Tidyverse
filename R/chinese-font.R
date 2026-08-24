# Configure a Chinese-capable font for graphics produced by this course.
#
# showtext renders text as paths/raster glyphs inside the graphics device, so
# Chinese labels remain readable in HTML, PNG and PDF outputs.  The function
# uses fonts already installed on the computer and never downloads a font.
setup_course_chinese_font <- function(enable = TRUE, quiet = TRUE) {
  fallback <- "sans"

  if (!requireNamespace("showtext", quietly = TRUE) ||
      !requireNamespace("sysfonts", quietly = TRUE)) {
    if (!quiet) {
      warning("未安装 showtext/sysfonts，图形将使用系统默认 sans 字体。")
    }
    options(course.chinese.font = fallback)
    return(fallback)
  }

  candidates <- c(
    # macOS: a TrueType file is preferred over a TTC collection.
    "/System/Library/Fonts/Supplemental/Arial Unicode.ttf",
    "/System/Library/PrivateFrameworks/FontServices.framework/Resources/Reserved/PingFangUI.ttc",
    "/System/Library/Fonts/STHeiti Medium.ttc",
    # Windows.
    "C:/Windows/Fonts/msyh.ttc",
    "C:/Windows/Fonts/simhei.ttf",
    # Common Linux locations.
    "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
    "/usr/share/fonts/truetype/wqy/wqy-microhei.ttc"
  )
  font_path <- candidates[file.exists(candidates)][1]

  # If none of the standard paths exists, ask systemfonts for a suitable font.
  if (is.na(font_path) && requireNamespace("systemfonts", quietly = TRUE)) {
    available <- systemfonts::system_fonts()
    suitable <- grepl(
      "PingFang|Noto Sans CJK|Microsoft YaHei|WenQuanYi|Heiti|Songti|Arial Unicode",
      available$family,
      ignore.case = TRUE
    )
    available <- available[suitable & file.exists(available$path), , drop = FALSE]
    if (nrow(available) > 0) font_path <- available$path[[1]]
  }

  family <- fallback
  if (!is.na(font_path)) {
    registered <- "course-cn" %in% sysfonts::font_families()
    if (!registered) {
      registered <- !inherits(
        try(sysfonts::font_add("course-cn", regular = font_path), silent = TRUE),
        "try-error"
      )
    }
    if (registered) family <- "course-cn"
  }

  showtext::showtext_opts(dpi = 144)
  showtext::showtext_auto(enable = enable)
  options(course.chinese.font = family)

  if (!quiet && identical(family, fallback)) {
    warning("未找到可注册的中文字体，图形将使用系统默认 sans 字体。")
  }
  family
}

course_chinese_font <- function() {
  getOption("course.chinese.font", "sans")
}
