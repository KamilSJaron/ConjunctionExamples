.PHONY : plot
plot : figures/width_over_time_wo_selection.png figures/rotation_plot.png

## rotation.out : perfrom a simulation
%.out : %.txt
	conjunction $< 1> $@ 2> $*.err
	conjunction -v > figures/version

## rotation.tsv : compute widths
rotation.tsv : rotation.out
	Rscript ../../scripts/compute_widths.R rotation

## figures/variance_of_allele_frequency_under_drift.pdf : plot simulated results against theoretical expecation
figures/width_over_time_wo_selection.png : collapse.R rotation.tsv rotation.txt
	mkdir -p figures
	Rscript $<

figures/rotation_plot.png : rotation.R rotation.tsv rotation.txt
	mkdir -p figures
	Rscript $<


.PHONY : clean
clean:
	rm figures/* rotation.tsv rotation.out rotation.err

## make test will foce recomputation of the test
.PHONY : test
test: clean plot
