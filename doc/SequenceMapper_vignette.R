## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ---- message = FALSE, warning = FALSE, eval = FALSE---------------------
#  library(devtools)
#  # if you don't have the package, run install.packages("devtools")
#  install_github("Benji-Wagner/SequenceMapper")

## ------------------------------------------------------------------------
library(SequenceMapper)
reads_table <- get_reads_table()
barcodes_table <- get_barcode_table()

## ---- message = FALSE, warning = FALSE-----------------------------------
library(dplyr)
# if you don't have this package, run install.packages("dplyr")

mapped_reads <- map_reads(reads_table = reads_table, 
  barcodes_table = barcodes_table, distance_threshold = 2)

## ------------------------------------------------------------------------
mapped_reads %>% 
  group_by(mapped_barcodes) %>%
  summarize(Number_Mapped = n(), Proportion_Mapped = n()/nrow(.))


## ------------------------------------------------------------------------
library(ggplot2)
# if you don't have this package, run install.packages("ggplot2")

mapped_reads %>% 
  group_by(mapped_barcodes) %>%
  summarize(Number_Mapped = n(), Proportion_Mapped = n()/nrow(.)) %>% 
  ggplot(mapping = aes(x = Number_Mapped)) + 
  geom_histogram(bins = 40) +
  xlab("Number of Reads Mapped") +
  ylab("Count") +
  ggtitle("Reads Mapped Per Barcode")

