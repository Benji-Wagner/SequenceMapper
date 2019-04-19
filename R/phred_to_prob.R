#' Convert Phred Score to Probability
#'
#' \code{phred_to_prob} converts a series of \href{https://en.wikipedia.org/wiki/Phred_quality_score}{phred scores},
#' which are ASCII characters used to encode the probabilities of a sequencing error for given base calls
#' in a sequence, to a vector of probability values.
#' \code{phred_to_prob} is called by \code{\link{calculate_probability}}.
#'
#' @param phred_score A string of Phred scores. Each character is a representation of the probability that
#' the corresponding base call is an error.
#' @return Returns a numeric vector of probabilities with length equal to the number of characters given in
#' \code{phred_score}

phred_to_prob <- function(phred_score){
  scores <- utf8ToInt(phred_score) - 33
  phred_prob <- 10^-(scores/10)
  return(phred_prob)
}
