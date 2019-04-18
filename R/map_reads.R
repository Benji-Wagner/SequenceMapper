#' Map Reads to Reference Barcodes
#'
#' \code{map_reads} is the primary workhorse of this package. It iterates through the reads_table,
#' finds the barcodes that are within 2 Hamming distances, and then computes the probability of
#' the read mapping to each barcode that is within 2 Hamming distances. Then, out of this list
#' of probabilities, it selects the first barcode with the greatest probability of being a match.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom dplyr n
#' @importFrom stats na.omit
#' @param barcodes_table The full table of reference barcodes, which contains a column titled \code{Labels},
#'      which contains the sequence ID, and another called \code{Code}, which contains the barcode sequence.
#' @param reads_table The full table of reads, which contains a column titled \code{Read_ID}, another called
#'      \code{Called_Read}, and a third column titled \code{Phred_Score}.
#' @param distance_threshold Integer specifying the Hamming distance threshold for which we want to filter barcodes
#' @export
#' @return Returns the original reads table along with the barcode that was mapped and the probability of
#' the map.
#' @examples
#' mapped_reads <- map_reads(reads_table = reads_table, barcodes_table = barcodes_table)
#' mapped_reads %>% group_by(mapped_barcodes) %>%
#'      summarize(Number_Mapped = n(), Proportion_Mapped = n()/nrow(mapped_reads))

map_reads <- function(barcodes_table, reads_table, distance_threshold = 2){
  print("Mapping reads to references... This may take some time. Go grab a coffee or something.")
  mapped_barcodes <- c()
  mapped_probabilities <- c()

  for(i in 1:nrow(reads_table)){

    filtered_barcodes <- get_mapped_barcode_indices(barcodes = barcodes_table$Code, 
                                                    read = reads_table$Called_Read[i], 
                                                    distance_threshold = distance_threshold)

    if(is_empty(filtered_barcodes)){
      mapped_probabilities <- c(mapped_probabilities, NA)
      mapped_barcodes <- c(mapped_barcodes, NA)
    }
    else{
      match_probabilities <- get_index_of_optimal_mapping(barcodes = barcodes_table$Code,
                                                          read = reads_table$Called_Read[i],
                                                          read_phred = reads_table$Phred_Score[i],
                                                          filtered_barcodes = filtered_barcodes)
      map_index <- which.max(match_probabilities)
      mapped_probabilities <- c(mapped_probabilities, match_probabilities[map_index])
      mapped_barcodes <- c(mapped_barcodes, barcodes_table$Code[filtered_barcodes][map_index])
    }
  }
  return(cbind(reads_table, mapped_barcodes, mapped_probabilities) %>% na.omit())
}
