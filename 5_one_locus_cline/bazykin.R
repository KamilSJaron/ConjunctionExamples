  # # # # # # # # # # # #
 # # #  BAZYKIN NM # # #
# # # # # # # # # # # #

library(ConjunctionStats)

sim <- ReadSummary('bazykin.out')
GradTable <- ReadSetting('setting.txt')
GradTable <- FillSetting(sim,GradTable)

simLM <- ReadSummary('bazykinLM.out')
GradTableLM <- ReadSetting('settingLM.txt')
GradTableLM <- FillSetting(simLM,GradTableLM)



x <-seq(0.01,0.99,by=0.01)

pdf('Bazykin.pdf')
	plot(x,twidth(x,sqrt(0.5)),type='l',ylim=c(0,max(GradTable$width)),xlab = 's',ylab = 'w')
	points(width ~ s,pch = 20,data=GradTable)
	lines(x,twidth(x,sqrt(0.25)), col = 'red')
	points(width ~ s,pch = 20,data=GradTableLM, col = 'red')
dev.off()
