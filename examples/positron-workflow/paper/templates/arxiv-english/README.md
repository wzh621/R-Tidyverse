# English IMS statistics template

This teaching template uses the `imsart` class and author-year bibliography
style found in the arXiv source of:

- Chen, Y. and Dubey, P. (2026), “DiPMInd: Distance Profile based Mutual
  Independence testing for random objects”, arXiv:2412.06766, accepted by
  *The Annals of Statistics*.

The upstream `imsart.cls`, `imsart.sty` and `imsart-nameyear.bst` files are
kept unchanged. They are distributed under the LaTeX Project Public License,
as stated in their file headers. `main.tex` is a new course example.

From the project root, run:

```sh
Rscript build_papers.R
```

The paper reads the R-generated figure, table and numeric macros through
relative paths. Replace the title, authors, text and `references.bib` for a
real paper. Before journal submission, download the current files and author
instructions from the target journal.
