# Manuals for using 

## Coverage barplot and lineplot
`coverage_plots.R` is a command line tool to generate 
* coverage barplot
* coverage lineplot
* aneuploidy plots
* subgenome plots
* contig coverage plots

## Usages
Manuals here: `coverage_plots.R -h`
```sh
usage: exec/coverage_plots.R [-h] [--color_csv COLOR_CSV] [--cutoff CUTOFF] -i
                             COV_TSV [-l] -p PREFIX
                             [--reverse_contigs REVERSE_CONTIGS] [--suba SUBA]
                             [--subb SUBB] [--sub_suffix SUB_SUFFIX]

Generate coverage plot

optional arguments:
  -h, --help            show this help message and exit
  --color_csv COLOR_CSV
                        color csv RGB file
  --cutoff CUTOFF       coverage cutoff to remove background
  -i COV_TSV, --cov_tsv COV_TSV
                        input coverage tsv file
  -l, --legacy          legacy mode
  -p PREFIX, --prefix PREFIX
                        output prefix
  --reverse_contigs REVERSE_CONTIGS
                        contigs that need to inverse positions to
                        complementary strand
  --suba SUBA           A list of subgenome A contigs
  --subb SUBB           A list of subgenome B contigs
  --sub_suffix SUB_SUFFIX
                        suffix for subgenome contigs
```
## Examples
```sh
cd tests
exec/coverage_plots.R \
  --cutoff 0.2 \
  --cov_tsv data/example_cov_profiles.tsv \
  --reverse_contigs chr2_D \
  --suba \
  --subb \
  --sub_suffix 
```