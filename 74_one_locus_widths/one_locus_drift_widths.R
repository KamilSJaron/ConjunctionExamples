library(ConjunctionStats)
library(RColorBrewer)

GradTable <- ReadSetting()
sim <- ReadSummary('one_locus_widths.out')
GradTable <- FillSettingByHZAR(sim,GradTable)
write.table(GradTable, 'one_locus_widths.tsv')

GraTable_L1_medians <- data.frame(s = numeric(0), b = numeric(0), L1_width_H = numeric(0))
for(sel in unique(GradTable$s)){
  for(beta in unique(GradTable$b)){
    mw <- median(GradTable$width_H[GradTable$s == sel & GradTable$b == beta])
    GraTable_L1_medians <- rbind(GraTable_L1_medians, data.frame(s = sel, b = beta, L1_width_H = mw))
  }
}

GradTable <- read.table('../73_searching_for_edge/width_estimates.tsv')
GraTable_L20k_medians <- data.frame(s = numeric(0), b = numeric(0), width_H = numeric(0))
for(sel in unique(GradTable$s)){
  for(beta in unique(GradTable$b)){
    mw <- median(GradTable$width_H[GradTable$s == sel & GradTable$b == beta])
    GraTable_L20k_medians <- rbind(GraTable_L20k_medians, data.frame(s = sel, b = beta, width_H = mw))
  }
}

colnames(GraTable_L1_medians)[3] <- 'L1_width_H'
GradTable <- merge(GraTable_L20k_medians, GraTable_L1_medians)

GradTable$ss_L1 <- 4 / GradTable$L1_width_H^2
GradTable$ss_H <- 4 / GradTable$width_H^2

GradTable$sss <- GradTable$ss_H / GradTable$ss_L1

pal <- brewer.pal(7,'RdYlGn')

pdf('sss_agains_1L_equivalent.pdf')
PlotStat(GradTable, stat = 'sss', par1 = 's', par2 = 'b',
         legend_position = 'topleft', pal = pal)
dev.off()

#GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)

#pdf('sss_agains_1L_equivalent.pdf')
#PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'b',
#         legend_position = 'topright', pal = pal)
#dev.off()
