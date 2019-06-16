#' Create barplot
#' @param cov coverage object
#' @export
cov.barplot <- function(...) UseMethod('cov.barplot')

#' generate coverage barplot
#' @param cov_df coverage data.frame
#' @param sample sample name
#' @param cols vector of colors for each chromosome
#' @param contigs a list of contigs to visualize in order
#' @param inverse_contig list of contigs need to reverse their physical postion
#' @param is_D: whether the subgenome is a D subgenome
#' @note This method assumes that bin sizes of the genome are identical, such
#' that bin index is a good proxy for the bin's physical location. This method
#' won't reflect the true position if bin size of the genome are not equal.
#' @export
cov.barplot <- function (
  cov_df, sample, cols, contigs=NULL, inverse_contigs=NULL, is_D=F) {
  cov1 <- cov_df[cov_df$chr %in% contigs, ]
  min_binx = min(cov1$binx)
  max_binx = max(cov1$binx)
  # generate base plot
  if(is_D) {
    plot(cov1$bidx, cov1[[sample]], ylim=c(0,5), cex = 0, xaxt='n',
         xlab=NA, ylab='cov', xlim=c(min_bidx, max_bidx))
  } else {
    plot(cov1$pos, cov1[[sample]], ylim=c(0,5), cex = 0, xaxt='n',
         xlab=NA, ylab='cov', main=sample, xlim=c(min_bidx, max_bidx))
  }
  # add coverage for each contig
  for (i in contigs) {
    if (is_D) {
      chr = i - 14
    } else {
      chr = i
    }
    if (!is.null(inverse_contigs) & (i %in% inverse_contigs)) {
      bidx = rev(cov1$bidx[cov1$chr==i])
      mtext(paste('chr', chr, '*', sep=''), side=1,
            at=mid_pos(cov1$bidx[cov1$chr==i]), cex=0.8)
    } else {
      bidx = cov1$bidx[cov1$chr==i]
      mtext(paste('chr', chr, sep=''), side=1,
            at=mid_pos(cov1$bidx[cov1$chr==i]), cex=0.8)
    }
    # add ploidy lines
    segments(bidx, 0, bidx, cov1[cov1$chr==i, sample], cols[i])
    grid(NA, 5, lwd=1.5)
  }
  return(1)
}


#' Create barplot
#' @param cov coverage object
#' @param prefix output prefix
#' @param cols color codes
#' @export
cov.barplot<- function(cov) {
  .is.cov(cov)
  options(bitmapType='cairo')
  png(paste0(cov$prefix,'_coverage_scatterplot.png'), width=2500,
      height=cov$n_sample*420, unit='px', res=300)
  par(mfrow=c(cov$n_sample * 2, 1))
  for (sample in names(cov$df)[cov$sample_idx]) {
    par(mar=c(1.5, 5, 1, 0.2))
    cov.barplot(cov$df, sample, cols, cov$suba, cov$inverse_contigs)
    cov.barplot(cov$df, sample, cols, cov$subb, is_D=T)
  }
  dev.off()
  return(1)
}