#' Calculate Joint Probability of Map
#'
#' \code{calculate_probability} takes a read and reference of equal length \code{n}, finds the positions of mismatch,
#' then calculates the joint probability of the read mapping to the reference based on the given phred score.
#' For a given position in a mapping and \code{P} being the probability of error at that position, the probability
#' of mapping is \eqn{1 - P} if the calls are the same, and \eqn{P/3} if the calls are different.
#' If there are no mismatches, the joint probability is \eqn{(1 - P)^n}.
#'
#' @param reference The barcode sequence to which \code{read} maps to. Should be the same length as \code{read}.
#' @param read The read sequence which maps to \code{barcode}. Should be the same length as \code{barcode}.
#' @inheritParams phred_to_prob
#' @return Returns a scalar joint probability
#' @examples
#' phred_to_prob('BEEEEFEFEEEFBEEDEE')
#' phred_to_prob('989BBAB7A3E667BAA?')

get_index_of_optimal_mapping <- function(barcodes, read, read_phred, filtered_barcodes){

  match_probabilities <- c()
  for(j in 1:length(filtered_barcodes)){
    reference <- barcodes[filtered_barcodes][j]

    match_probabilities <- c(match_probabilities, calculate_probability(reference, read, read_phred))
  }
  return(match_probabilities)
}
