COMP_WIDTHS = Rscript ../../scripts/compute_widths.R

## make plot : create output figure
.PHONY : plot
plot : figures/bazykin.png

include ../../scripts/template.mk

figures/bazykin.png : bazykin.R sims/bazykin.out sims/bazykin_LM.out
	mkdir -p figures
	Rscript $<
