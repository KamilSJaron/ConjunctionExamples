  # # # # # # # # # # # #
 # # #  BAZYKIN NM # # #
# # # # # # # # # # # #

library(ConjunctionStats)

GradTable <- read.table('sims/bazykin.tsv')
GradTableLM <- read.table('sims/bazykin_LM.tsv')

x <-seq(0.01,0.99,by=0.01)

png('figures/bazykin.png')
	plot(x, twidth(x,sqrt(0.5)), type='l',
	     ylim=c(0,max(GradTable$width)), xlab = 's', ylab = 'w')
	points(width ~ s, pch = 20, data = GradTable)
	lines(x, twidth(x,sqrt(0.25)), col = 'red')
	points(width ~ s, pch = 20, data = GradTableLM, col = 'red')
dev.off()
