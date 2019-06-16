#' @export
cov.lineplot <- function(...) UseMethod('cov.lineplot')


#' Overlay coverage on top of each other in one plot
#' @param cov coverage df
#' @param prefix output figure prefix
#' @param cols color vector for each contig
#' @export
#' 
cov.lineplot.default <- function(cov_df, sample_name, sample_color, chr) {
  lines(cov_df$bidx, cov_df[[sample_name]], col=sample_color)
  mtext(chr, side=1, at=mid_pos(cov_df$bidx), cex=0.8)
  abline(v=max(cov_df$bidx+0.5), lty=5, lwd=2)
}


cov.lineplot.cov <- function (cov) {
  .is.cov(cov)
  sample_names = names(cov$df)[cov$sample_idx]
  sample_colors = get_colors(cov$n_samples)

  # generate line plots
  pdf(paste(cov$prefix, '_lineplot.pdf', sep=''), 
      width = length(cov$contigs)/0.75, 
      height = 8)
  par(mfrow=c(2,1)) # create two panels
  # plot for each subgenome
  for (subg in cov$sub_suffix) {
    has_chr_label = F  # whether plot has chr label on x axis
    subcovdf = cov$df[which(grepl(subg, cov$df$chr)), ]

    plot(1, ylim=c(-0.4, 5), cex = 0, xaxt='n', xlab=NA, ylab='cov', 
         xlim=c(min(subcovdf$bidx), max(subcovdf$bidx)), 
         main=paste('subgenome', subg, sep=''))
    # plot each sample
    for (sample_idx in 1:length(sample_names)) {
      
      sample_name = sample_names[sample_idx]
      sample_color = sample_colors[sample_idx]
        # plot chrs
      for (chr in head(cov[[subg]])) {
        chr_cov_df = subcovdf[subcovdf$chr==chr, ]
        cov.lineplot(chr_cov_df, sample_name, sample_idx, chr)
      }
    }
  }
  dev.off()
}
