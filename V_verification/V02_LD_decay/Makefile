.PHONY : all
plot : figures/LD_decay.pdf

## LD_chrom.out : preform sim for C = 2, L = 1
LD_chrom.out : setting_C.txt
	conjunction $< > $@ 2> LD_chrom.err

## LD_loci.out : preform sim for C = 1, L = 2
LD_loci.out : setting_L.txt
	conjunction $< > $@ 2> LD_loci.err

## sims : perform both simulations
.PHONY : sims
sims : LD_loci.out LD_chrom.out

## plot : plot simulated results against theoretical expecation
figures/LD_decay.pdf : LD_decay.R sims setting_C.txt setting_L.txt
	Rscript $<

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
