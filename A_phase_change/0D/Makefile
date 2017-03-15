C1_SET=$(wildcard sims/setting_C1_*.txt)
C1_OUT=$(patsubst %.txt, %.out, $(C1_SET))
C5_SET=$(wildcard sims/setting_C5*.txt)
C5_OUT=$(patsubst %.txt, %.out, $(C5_SET))
C10_SET=$(wildcard sims/setting_C10*.txt)
C10_OUT=$(patsubst %.txt, %.out, $(C10_SET))
C20_SET=$(wildcard sims/setting_C20*.txt)
C20_OUT=$(patsubst %.txt, %.out, $(C20_SET))

ALL_OUT=$(C1_OUT) $(C5_OUT) $(C10_OUT) $(C20_OUT)

## make plot : create output figure
.PHONY : plot
plot : 0D_sss_C1_lambda0.9.png

# pictures are made really terribly
0D_sss_C1_lambda0.9.png : $(C1_OUT) $(C5_OUT) $(C10_OUT) $(C20_OUT)
	Rscript effective_proportion_of_genome_epistasis.R

.PHONY: sim_all
sim_all : simC1 simC5 simC10 simC20

#.PHONY: dl_all
#sim_all :
#	DL_SCRIPT

include ../../scripts/template.mk

.PHONY: simC1
simC1 : $(C1_OUT)

.PHONY: simC5
simC5 : $(C5_OUT)

.PHONY: simC10
simC10 : $(C10_OUT)

.PHONY: simC20
simC20 : $(C20_OUT)
