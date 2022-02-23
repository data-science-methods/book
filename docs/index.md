--- 
title: "Methods of Data Science I"
author: "Dan Hicks, <hicks.daniel.j@gmail.com>"
github-repo: data-science-methods/book
date: "Wed Feb 23 16:03:34 2022"
site: bookdown::bookdown_site
# documentclass: book
bibliography: [book.bib, packages.bib]
link-citations: yes
description: "This document is a set of notes (and perhaps later a textbook) for a course on data science methods for graduate students in social and behavioral sciences."
---





# Preface # {-} 

This document is a set of notes (and perhaps later a textbook) for a course on data science methods for graduate students in social and behavioral sciences, taught by Professor Dan Hicks (they/them), UC Merced. 

The course site is available [here](..). 

<!-- PDF versions of each chapter can be found here:  [Handouts](handouts/index.html) -->

<!-- (The URLs to the handouts are buggy.  To get to them, look for `handout/handout/` in the URL; delete the second `handout/`.) -->

-----

These notes were written in [RStudio](http://www.rstudio.com/ide/) using [bookdown](http://bookdown.org/). The complete source is available on [GitHub](https://github.com/data-science-methods/book/) and is automatically rebuilt using GitHub actions. 

This version of the book was built with R version 4.1.2 (2021-11-01), [pandoc](https://pandoc.org/) version 2.13, and the following packages:



|package      |version |source         |
|:------------|:-------|:--------------|
|assertthat   |0.2.1   |CRAN (R 4.1.0) |
|bookdown     |0.24    |CRAN (R 4.1.0) |
|datasauRus   |0.1.4   |CRAN (R 4.1.0) |
|desc         |1.4.0   |CRAN (R 4.1.0) |
|ggbeeswarm   |0.6.0   |CRAN (R 4.1.0) |
|ggforce      |0.3.3   |CRAN (R 4.1.0) |
|nycflights13 |1.0.2   |CRAN (R 4.1.0) |
|printr       |0.2     |CRAN (R 4.1.0) |
|reticulate   |1.24    |CRAN (R 4.1.2) |
|sessioninfo  |1.2.2   |CRAN (R 4.1.0) |
|skimr        |2.1.3   |CRAN (R 4.1.0) |
|sloop        |1.0.1   |CRAN (R 4.1.0) |
|tictoc       |1.0.1   |CRAN (R 4.1.0) |
|tidylog      |1.0.2   |CRAN (R 4.1.0) |
|tidyverse    |1.3.1   |CRAN (R 4.1.0) |
|visdat       |0.5.3   |CRAN (R 4.1.0) |
|vroom        |1.5.7   |CRAN (R 4.1.0) |
