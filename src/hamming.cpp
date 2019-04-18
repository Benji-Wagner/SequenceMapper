#include <Rcpp.h>
#include <string>
using namespace Rcpp;

//' Compute Hamming Distance
//'
//' \code{hamming} computes the hamming distance between two equal length strings. The hamming distance
//' is the number of different characters between strings. Is called by \code{\link{get_mapped_barcode_indices}}.
//'
//' @param str1 The first string, should be equal length to \code{str2}
//' @param str2 The second string, should be equal length to \code{str1}
//' @return Returns the hamming distance, a scalar integer
// [[Rcpp::export]]
int hamming(const std::string& str1, const std::string& str2) {
  int sdist = 0;

  for(int i = 0; i < str1.length(); ++i) {
    if(str1[i] != str2[i]) {
      sdist++;
    }
  }
  return(sdist);
}
