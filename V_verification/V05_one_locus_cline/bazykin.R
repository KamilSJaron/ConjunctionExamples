  # # # # # # # # # # # #
 # # #  BAZYKIN NM # # #
# # # # # # # # # # # #

library(ConjunctionStats)

GradTable <- ReadSetting('./sims/bazykin.txt')
sims <- ReadSummary('./sims/bazykin.out')
GradTable <- FillSetting(sims, GradTable, method = 'nlm')

GradTableLM <- read.table('sims/bazykin_LM.tsv')
simsLM <- ReadSummary('./sims/bazykin_LM.out')
GradTableLM <- FillSetting(simsLM, GradTableLM, method = 'hzar')

x <-seq(0.01,0.99,by=0.01)

png('figures/bazykin.png')
	plot(x, twidth(x,sqrt(0.5)), type='l',
	     ylim=c(0,max(GradTable$width)), xlab = 's', ylab = 'w')
	points(width ~ s, pch = 20, data = GradTable)
	lines(x, twidth(x,sqrt(0.25)), col = 'red')
	points(width ~ s, pch = 20, data = GradTableLM, col = 'red')
dev.off()
