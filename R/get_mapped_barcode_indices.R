#' Find Indices of Potential Barcode Mappings
#'
#' \code{get_mapped_barcode_indices} takes a vector of barcodes and a single read, then
#' returns the indices of the barcodes that were within two hamming distance units
#' from the read.
#'
#' @param barcodes Character vector of reference sequences
#' @param read Character string with the same length as each barcode in \code{barcodes}
#' @return Returns a vector of integers which are the indices of barcodes within 2 Hamming distance of the read
#' @examples
#' get_mapped_barcode_indices(barcodes = c('ACTG', 'AATG', 'GTCA'), read = 'ACTG')

get_mapped_barcode_indices <- function(barcodes, read, distance_threshold = 2){
  filtered_barcodes <- NULL
  for(j in 1:length(barcodes)){
    barcode <- barcodes[j]
    if(hamming(barcode, read) <= distance_threshold){
      filtered_barcodes <- c(filtered_barcodes, j)
    }
  }
  return(filtered_barcodes)
}
