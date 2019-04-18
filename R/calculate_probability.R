#' Calculate Joint Probability of Map
#'
#' \code{calculate_probability} takes a read and reference of equal length \code{n}, finds the positions of mismatch,
#' then calculates the joint probability of the read mapping to the reference based on the given phred score.
#' For a given position in a mapping and \code{P} being the probability of error at that position, the probability
#' of mapping is \eqn{1 - P} if the calls are the same, and \eqn{P/3} if the calls are different.
#' If there are no mismatches, the joint probability is \eqn{(1 - P)^n}.
#' @importFrom purrr is_empty
#' @param reference The barcode sequence to which \code{read} maps to. Should be the same length as \code{read}.
#' @param read The read sequence which maps to \code{barcode}. Should be the same length as \code{barcode}.
#' @inheritParams phred_to_prob
#' @return Returns a scalar joint probability, which is the product of marginal probabilities obtained from
#' \code{phred_to_prob}
#' @examples
#' calculate_probability('GTAGAAACTTAGGGGTGC', 'ACGAACCTGAGACACCGG', 'BEEEEFEFEEEFBEEDEE')
#' calculate_probability('AGAGAAACTTAGGGGTGC', 'AGCTTAAAGAGCTACAAG', '989BBAB7A3E667BAA?')

calculate_probability <- function(reference, read, phred_score){

  reference_split <- unlist(strsplit(reference, ""))
  read_split <- unlist(strsplit(read, ""))
  mismatch_index <- which(reference_split != read_split)

  read_scores <- phred_to_prob(phred_score)

  if(purrr::is_empty(mismatch_index)){
    return(prod(1 - read_scores))
  }
  else{
    match_scores <- read_scores[-mismatch_index]
    mismatch_scores <- read_scores[mismatch_index]

    return(prod(1 - read_scores[-mismatch_index]) * prod(read_scores[mismatch_index]/3))
  }
}
