#' Get Barcode Dataframe
#'
#' \code{get_barcode_table} reads in the fasta file that is included with this package.
#' @importFrom readr read_lines
#' @importFrom tibble tibble
#' @return Returns a dataframe of barcode identifiers and reference barcodes
#' @export
#' @examples
#' barcodes_df <- get_barcode_table()

get_barcode_table <- function(){
  fasta_file <- read_lines(system.file("extdata", "my.gen.fasta", package = "SequenceMapper"))
  barcodes_table <- tibble("Labels" = fasta_file[c(TRUE, FALSE)], "Code" = fasta_file[c(FALSE, TRUE)])
  return(barcodes_table)
}
