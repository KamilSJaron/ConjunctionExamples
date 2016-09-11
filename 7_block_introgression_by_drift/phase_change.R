# # # # # # # # # # # # #
# # #  Phase Change # # #
# # # # # # # # # # # # #

library(ConjunctionStats)

# conjunction drift_blocks_introgression_setting.txt 1> drift_blocks_introgression.out 2> drift_block_introgression.err
# conjunction drift_blocks_introgression_settingBD.txt 1> drift_blocks_introgressionBD.out 2> drift_block_introgressionBD.err
# conjunction setting_introblocks_LM.txt 1> introblocks_LM.out 2> introblocks_LM.err

sim <- ReadSummary('introblocks_HM.out')
GradTable <- ReadSetting('setting_introblocks.txt')
GradTable <- FillSetting(sim,GradTable)

pdf('widths_selection_beta.pdf')
  # epistatic selection plays a role, selection as well
  # could we define "selection" as AUC of the 1 - fitness function?
  PlotWidths(GradTable, 's', 'b')
dev.off()

PlotWidths(GradTable, 's', 'D') # drift seems it does not, plot is not saved

#ReadSetting('drift_blocks_introgression_setting.txt')
#ReadSetting('drift_blocks_introgression_settingBD.txt')

######################################################
# effective proportion computed directly from blocks #
######################################################

GradTable <- ReadSetting('setting_introblocks_LM.txt')
sim <- ReadSummary('introblocks_LM.out')
GradTable <- FillSetting(sim,GradTable)

pdf('widths_generations_demezise.pdf')
  PlotWidths(GradTable, 'G', 'D', 'topleft')
dev.off()

# read the distributions
introblocks_LM <- getBlockSummaries('./', pattern = '.tsv')

GradTable$Pj <- NA
for(run in 1:length(sim)){
  simtab <- sim[[run]][order(sim[[run]]$order),]
  demes <- names(introblocks_LM[['A']][[run]])
  blockBulk <- c()

  for(deme in demes[simtab$meanHI < 0.5 & simtab$meanHI != 0]){
    blockBulk <- c(blockBulk,introblocks_LM[['B']][[run]][[deme]])
  }

  for(deme in demes[simtab$meanHI > 0.5 & simtab$meanHI != 1]){
    blockBulk <- c(blockBulk,introblocks_LM[['A']][[run]][[deme]])
  }

  GradTable$Pj[run] <- mean(blockBulk / GradTable$L[run])
  GradTable$pop_size[run] <- length(blockBulk) # is pop_size == number of blocks ??? Kind of strange, right?
}
GradTable$sss <- GradTable$D / (GradTable$s * GradTable$pop_size * GradTable$Pj)
GradTable$theta <- GradTable$s / GradTable$r

palette <- brewer.pal(5,"RdYlBu")[c(-3,-4)]

pdf('effective_proportion_1D_demesize.pdf')
plot(numeric(0),numeric(0), lwd = 1.5, lty = 2, type = 'l', xlim = c(1,1000), ylim = c(0,0.9), xlab = 'D', ylab = expression('s* / S'))

for(index in 1:3){
  points(sss ~ G, data = GradTable, pch = 20, cex = 1.4, col = palette[index], subset = c(GradTable$D == unique(GradTable$D)[index]))
  lines(sss ~ G, data = GradTable, col = palette[index], subset = c(GradTable$D == unique(GradTable$D)[index]))
}

legend(0, 0.9, unique(GradTable$D), title = 'D', pch = 20,cex=1.4,lty=1, col=palette)
dev.off()

###########################################################
# Effective proportion computed using effective selection #
###########################################################

GradTable <- ReadSetting('setting_introblocks_LM.txt')
sim <- ReadSummary('introblocks_LM.out')
GradTable <- FillSetting(sim,GradTable)
