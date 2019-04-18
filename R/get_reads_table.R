#' Get Reads Dataframe
#'
#' \code{get_reads_table} reads in the fastq file that is included with this package.
#' @importFrom readr read_lines
#' @importFrom tibble tibble
#' @return Returns a dataframe of sample identifiers, the called reads, and their phred scores
#' @export
#' @examples
#' reads_df <- get_reads_table()


get_reads_table <- function(){
  fastq_file <- read_lines(system.file("extdata", "my.gen.fastq", package = "SequenceMapper"))
  reads_table <- tibble("Read_ID" = fastq_file[c(TRUE, FALSE, FALSE, FALSE)],
                        "Called_Read" = fastq_file[c(FALSE, TRUE, FALSE, FALSE)],
                        "Phred_Score" = fastq_file[c(FALSE, FALSE, FALSE, TRUE)])
  return(reads_table)
}
