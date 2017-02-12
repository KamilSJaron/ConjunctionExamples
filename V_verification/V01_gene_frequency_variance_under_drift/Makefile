COMP_WIDTHS = Rscript ../../compute_widths.R

## make plot : create output figure
.PHONY : plot
plot : figures/variance_of_allele_frequency_under_drift.png

include ../../scripts/template.mk

## allele_freq_var_hi_only.out : extract hybrid indexes from sim output
sims/allele_freq_var_hi_only.out : sims/allele_freq_var.out
	grep "0:" $< | awk '{print $$8}' > $@

# figures/variance_of_allele_frequency_under_drift.pdf : plot simulated results against theoretical expecation
figures/variance_of_allele_frequency_under_drift.png : gene_freq_under_drift.R sims/allele_freq_var_hi_only.out
	mkdir -p figures
	Rscript $<
