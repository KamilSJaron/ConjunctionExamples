COMP_WIDTHS = Rscript ../../scripts/compute_widths.R

## make plot : create output figure
.PHONY : plot
plot : figures/bazykin.png

include ../../scripts/template.mk

figures/bazykin.png : bazykin.R sims/bazykin.tsv sims/bazykin_LM.tsv
	mkdir -p figures
	Rscript $<
