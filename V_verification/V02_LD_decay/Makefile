COMP_WIDTHS = Rscript ../../compute_widths.R

## make plot : create output figure
.PHONY : plot
plot : figures/LD_decay.png

include ../../scripts/template.mk

figures/LD_decay.png : LD_decay.R sims/LD_loci.out sims/LD_chrom.out
	mkdir -p figures
	Rscript $<

## make help : this help
## make clean : delete everything computed
## NOT WORKING SO FAR:
## make redo : invoke recalculation of sims if newer binary is installed in PATH
## make download : download simulation results form server
