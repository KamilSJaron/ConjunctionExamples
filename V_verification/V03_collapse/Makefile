.PHONY : plot
plot : figures/width_over_time_wo_selection.png figures/rotation_plot.png

include ../../scripts/template.mk

## figures/variance_of_allele_frequency_under_drift.pdf : plot simulated results against theoretical expecation
figures/width_over_time_wo_selection.png : collapse.R sims/rotation.out
	mkdir -p figures
	Rscript $<

figures/rotation_plot.png : rotation.R sims/rotation.tsv
	mkdir -p figures
	Rscript $<

## make test will foce recomputation of the test
.PHONY : test
test: clean plot
