library('testthat')
library('covisr')
context('exec')

testthat("Test coverage_plot.R", {
  CMD = paste(
    'exec/coverage_plots.R', 
    '--cov_tsv tests/testthat/data/example_profile.tsv',
    '--cutoff 0.25',
    '--suba chr1_A chr2_A',
    '--subb chr2_D chr1_D',
    '--reverse_contigs chr2_D',
    '--sub_suffix _A _D',
    '--prefix example',
    sep=' '
  )
  system(CMD)
})

testthat("Test coverage_barplot.R", {
  CMD = paste(
    'exec/coverage_barplot.R',
    ''
  )
})

