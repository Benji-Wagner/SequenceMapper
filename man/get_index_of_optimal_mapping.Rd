% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_index_of_optimal_mapping.R
\name{get_index_of_optimal_mapping}
\alias{get_index_of_optimal_mapping}
\title{Get Optimal Mapping Indices}
\usage{
get_index_of_optimal_mapping(barcodes, read, read_phred, filtered_barcodes)
}
\arguments{
\item{barcodes}{A vector of reference barcodes. Each barcode should be of equal length to \code{read}.}

\item{read}{The read sequence which maps to \code{barcode}. Should be the same length as \code{barcode}.}

\item{read_phred}{The phred score for \code{read}. Should be the same length as \code{read}.}

\item{filtered_barcodes}{A non-empty vector of integers containing the indices for the barcodes within
a certain distance from the read.}
}
\value{
Returns a numeric vector of probabilities
}
\description{
\code{get_index_of_optimal_mapping} takes a table of barcodes, a single read, the read's phred score, and
the indices of the barcodes that are within a certain Hamming Distance of the read. This function iterates
through the indices of the barcodes, calculates the joint probability of the read mapping to the barcode,
and then concatenates this value to a vector. Eventually returns a vector of joint probabilities.
}
