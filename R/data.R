#' Barcode Reference Sequences
#'
#' A dataset containing identifiers of 500 barcode sequences.
#'
#' @format A data frame with 500 rows and 2 variables:
#' \describe{
#'   \item{Labels}{Barcode Sequence IDs}
#'   \item{Code}{DNA Sequences of length 18}
#' }
#' @source Randomly generated sequences
"barcodes_table"


#' Sample Read Sequences
#'
#' A dataset containing identifiers, called bases, and Phred Quality Scores of 10000 reads.
#'
#' @format A data frame with 10000 rows and 3 variables:
#' \describe{
#'   \item{Read_ID}{Unique Identifier containing the machine name, the run ID, the flowcell ID,
#'   the x-coordinate of the cluster within the tile,
#'   the y-coordinate of the cluster within the tile,
#'   and a Y indicator if the read is filtered or N otherwise followed by the control bits}
#'   \item{Called_Read}{DNA Sequences of length 18}
#'   \item{Phred_Score}{ASCII-encoded probability of sequencing error of length 18}
#' }
#' @source Randomly generated sequences
"reads_table"