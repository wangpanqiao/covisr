#!/usr/bin/env Rscript
library('argparse')
library('devtools')
devtools::load_all(pkg="/Users/xiaoli/Dropbox/codes/covisr")


main <- function(cov_tsv, prefix, cutoff, ctg_map_file, sub_suffix, legacy, 
                 color_csv) {
  cov <- cov.init(cov_tsv=cov_tsv, cutoff=cutoff, prefix=prefix, 
                  ctg_map=read.csv(ctg_map, header=T, sep='\t'), 
                  sub_suffix=sub_suffix) # init coverage object
  if (legacy) {
    col <- legacy_colors(color_csv, SUBA, SUBB)
  }
  cov.lineplot(cov)
}


# input parser
if (!interactive()) {
  parser <- ArgumentParser(description='Generate coverage plot')
  parser$add_argument(
    '--color_csv', help='color csv RGB file')
  parser$add_argument(
    '--cutoff', help='coverage cutoff to remove background', default=0.25)
  parser$add_argument(
    '-i', '--cov_tsv', help='input coverage tsv file', required=T)
  parser$add_argument(
    '-l', '--legacy', help='legacy mode', action='store_true')
  parser$add_argument(
    '-p', '--prefix', help='output prefix', required=T)
  parser$add_argument(
    '-m', '--contig_map', help='contig mapping of two subgenomes'
  )
  parser$add_argument(
    '--sub_suffix', help='suffix for subgenome contigs', nargs='+', 
    default=c('_A', '_D'))
  args <- parser$parse_args()
  main(args$cov_tsv, args$prefix,  args$cutoff, args$contig_map, 
       args$sub_suffix, args$legacy, args$color_csv)
}
