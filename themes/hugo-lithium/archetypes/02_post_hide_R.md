---
title: "{{ replace .TranslationBaseName "-" " " | title }}"
date: {{ .Date }}
draft: true
tags: []
categories: []
output:
  blogdown::html_page:
    toc: no
    fig_width: 5
    fig_height: 5
link-citations: true    
csl: ../../static/bibtex/acm-sig-proceedings.csl
bibliography: ../../static/bibtex/probability.bib
---


```{r setup, echo = FALSE, message = FALSE, warning = FALSE}
## Load frequently used packages for blog posts
library(tidyverse)
library(here)

## For R images to display well in the RSS feed (disable for local preview)
# knitr::opts_knit$set(base.url = 'stefanengineering.com/post/')

# Don't show code by default
knitr::opts_chunk$set(echo = FALSE, warning = FALSE, comment = NA, message = FALSE)
knitr::opts_knit$set(global.par = TRUE)

# CB Palette like ESL
cbPalette <- c(
  "#999999", "#E69F00", "#56B4E9", "#009E73",
  "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# Set the theme
theme_set(
  theme_minimal(base_size = 15, base_family = "Arial") %+replace%
    theme(
      plot.caption = element_text(size = 9, color = "gray50", hjust=1)
      # panel.grid.major  = element_blank(),
      # panel.grid.minor  = element_blank()
    )
)
```

## Post content

Typical location to start editing since the bibliography chunk is hidden. Make sure that you selected `R Markdown (.Rmd)` as the _format_ option of the post when using the `New Post` `blogdown` addin.

## References
