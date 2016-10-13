library(ConjunctionStats)

GradTable <- ReadSetting()
sim <- ReadSummary('introblocks_73.out')
#GradTable <- FillSetting(sim,GradTable)
GradTable <- FillSettingByHZAR(sim,GradTable)
# sim <- FillSummary(sim,GradTable$center)

GradTable_zoomed <- ReadSetting('setting_zoom.txt')
sim_zoomed <- ReadSummary('edge_zoomed.out')
GradTable_zoomed <- FillSettingByHZAR(sim_zoomed,GradTable_zoomed)

GradTable <- rbind(GradTable, GradTable_zoomed)

GradTable$ss_H <- 4 / GradTable$width_H^2
GradTable$sss <- GradTable$ss_H / GradTable$s

PlotStat(GradTable, stat = 'sss', par1 = 'G', par2 = 's')
# after 200G it looks moreless stable, I will use time stapms as replicates
PlotStat(GradTable, stat = 'sss', par1 = 's', par2 = 'b',  'topleft')

# GradTable <- read.table('width_estimates.tsv')

GraTable_averages <- data.frame(s = numeric(0), b = numeric(0), width_H = numeric(0))
for(sel in unique(GradTable$s)){
  for(beta in unique(GradTable$b)){
    mw <- median(GradTable$width_H[GradTable$s == sel & GradTable$b == beta])
    GraTable_averages <- rbind(GraTable_averages, data.frame(s = sel, b = beta, width_H = mw))
  }
}

GraTable_averages$ss_H <- 4 / GraTable_averages$width_H^2
GraTable_averages$sss <- GraTable_averages$ss_H / GraTable_averages$s
GraTable_averages$AUFC <- getAUFC(GraTable_averages$s, GraTable_averages$b)

pal <- brewer.pal(7,'RdYlGn')
pdf('propotion_of_genome_vs_selection.pdf')
  PlotStat(GraTable_averages, stat = 'sss', par1 = 's', par2 = 'b',
          legend_position = 'topleft', pal = pal,
          xlab = 'selection',
          ylab = 'selection on one loci needed to maintain the same width / selection')
dev.off()

pdf('propotion_of_genome_vs_AUFC.pdf')
  PlotStat(GraTable_averages, stat = 'sss', par1 = 'AUFC', par2 = 'b',
          legend_position = 'topright', pal = pal,
          xlab = 'area under fitness curve',
          ylab = 'selection on one loci needed to maintain the same width / selection')
dev.off()

# PlotStat(GradTable, stat = 'sss', par1 = 's', par2 = 'b',  'topleft')
rm(list = ls())
library(RColorBrewer)

GradTable <- ReadSetting()
sim <- ReadSummary('introblocks_73.out')
GradTable_zoomed <- ReadSetting('setting_zoom.txt')
sim_zoomed <- ReadSummary('edge_zoomed.out')

getMinMeanF <- function(intable){ return(min(intable$meanf)) }
# unlist(lapply(sim_HM, getMinMeanF))
# conservative guess

GradTable$ecological_sel_center <- 1 - (1 - GradTable$s) / unlist(lapply(sim, getMinMeanF))
GradTable_zoomed$ecological_sel_center <- 1 - (1 - GradTable_zoomed$s) / unlist(lapply(sim_zoomed, getMinMeanF))

GradTable <- rbind(GradTable, GradTable_zoomed)
GradTable <- GradTable[order(GradTable$b, GradTable$s),]

GradTable$propotion_of_selection_in_the_center <- GradTable$ecological_sel_center / GradTable$s

pal <- brewer.pal(7,'RdYlGn')

pdf('propotion_of_selection_vs_selection.pdf')
  PlotStat(GradTable, stat = 'propotion_of_selection_in_the_center',
  par1 = 's', par2 = 'b', 'topleft', pal = pal)
dev.off()
