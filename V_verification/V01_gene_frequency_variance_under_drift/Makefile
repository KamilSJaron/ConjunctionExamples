.PHONY : plot
plot : figures/variance_of_allele_frequency_under_drift.pdf

## allele_freq_var_hi_only.out : extract hybrid indexes from sim output
allele_freq_var_hi_only.out : allele_freq_var.out
	grep "0:" $< | awk '{print $$8}' > $@

## allele_freq_var.out : perfrom a simulation
allele_freq_var.out : setting.txt
	conjunction 1> $@ 2> allele_freq_var.err

## figures/variance_of_allele_frequency_under_drift.pdf : plot simulated results against theoretical expecation
figures/variance_of_allele_frequency_under_drift.pdf : gene_freq_under_drift.R allele_freq_var_hi_only.out setting.txt
	Rscript $<

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
