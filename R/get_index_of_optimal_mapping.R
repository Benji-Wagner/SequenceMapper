#' Get Optimal Mapping Indices
#'
#' \code{get_index_of_optimal_mapping} takes a table of barcodes, a single read, the read's phred score, and
#' the indices of the barcodes that are within a certain Hamming Distance of the read. This function iterates
#' through the indices of the barcodes, calculates the joint probability of the read mapping to the barcode,
#' and then concatenates this value to a vector. Eventually returns a vector of joint probabilities.
#'
#' @param barcodes A vector of reference barcodes. Each barcode should be of equal length to \code{read}.
#' @param read The read sequence which maps to \code{barcode}. Should be the same length as \code{barcode}.
#' @param read_phred The phred score for \code{read}. Should be the same length as \code{read}.
#' @param filtered_barcodes A non-empty vector of integers containing the indices for the barcodes within
#' a certain distance from the read.
#' @return Returns a numeric vector of probabilities

get_index_of_optimal_mapping <- function(barcodes, read, read_phred, filtered_barcodes){

  match_probabilities <- c()
  for(j in 1:length(filtered_barcodes)){
    reference <- barcodes[filtered_barcodes][j]

    match_probabilities <- c(match_probabilities, calculate_probability(reference, read, read_phred))
  }
  return(match_probabilities)
}
