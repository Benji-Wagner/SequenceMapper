# SequenceMapper
This package aims to educate users on how sample DNA reads from high-throughput sequencing processes can be mapped
to reference barcodes. This package comes with some sample data that can be loaded and ran with the included functions.
The reads dataset comes with the read identifier, the called read, and the read's [Phred Score](https://en.wikipedia.org/wiki/Phred_quality_score). 
The barcodes dataset comes with the barcode identifier and the reference sequence.
The motivating problem is we want to find the number of reads that map to a particular barcode, but we want to
allow for mismatches. Thus, by using the Hamming Distance, we can map reads to barcodes that might not be an exact match.
Using the Phred Scores, we can also calculate the probability that a given read maps to a particular barcode by using
a probabilistic error model.

# Installation

```r
library(devtools)
# if you don't have the package, run install.packages("devtools")
devtools::install_github("Benji-Wagner/SequenceMapper", build_opts = c("--no-resave-data", "--no-manual"))
# must specify the build_opts to load the vignette
```

# Use Cases

The `SequenceMapper` package comes loaded with randomly generated 
[FASTQ](https://www.drive5.com/usearch/manual/fastq_files.html)
and [FASTA](https://zhanglab.ccmb.med.umich.edu/FASTA/) files. 

These files can be loaded like so:
```r
library(SequenceMapper)
reads_table <- get_reads_table()
barcodes_table <- get_barcode_table()
```

By calling the `map_reads` function, we can map all the reads in `reads_table` to a barcode in `barcodes_table`. 
This is done by computing the Hamming Distance between a given read and every barcode, then filtering out the barcodes
that are not within a certain Hamming Distance, which we can specify with the argument `distance_threshold`. 
Out of these filtered barcodes, we compute the joint probability of the read mapping to each barcode by using the read's
Phred Score. Finally, we take the first barcode with the greatest joint probability of mapping and add that barcode to the
corresponding read in the `reads_table`.

This process has been largely automated, and can be completed like so:
```r
library(dplyr)
# if you don't have this package, run install.packages("dplyr")

mapped_reads <- map_reads(reads_table = reads_table, 
  barcodes_table = barcodes_table, distance_threshold = 2)

# See the number of reads that mapped to a particular barcode and the 
# proportion of mapped reads that mapped to it
mapped_reads %>% group_by(mapped_barcodes) %>%
  summarize(Number_Mapped = n(), Proportion_Mapped = n()/nrow(.))
```

Here's a quick look at the distribution of reads mapped to a barcode:
```r
library(ggplot2)
# if you don't have this package, run install.packages("ggplot2")

mapped_reads %>% 
  group_by(mapped_barcodes) %>%
  summarize(Number_Mapped = n(), Proportion_Mapped = n()/nrow(.)) %>% 
  ggplot(mapping = aes(x = Number_Mapped)) + 
  geom_histogram(bins = 40) +
  xlab("Number of Reads Mapped to a Barcode") +
  ylab("Count") +
  ggtitle("Distribution of Reads Mapped Per Barcode")
```

# References

H. Li, J. Ruan, and R. Durbin.
Mapping short DNA sequencing reads and calling variants using mapping quality
scores.
*Genome Res., 18:1851, 2008.*
