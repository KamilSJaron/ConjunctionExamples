library(ConjunctionStats)
library(RColorBrewer)

GradTable_L1 <- ReadSetting('one_locus_setting.txt')
sim_L1 <- ReadSummary('one_locus_widths.out')
GradTable_L1 <- FillSettingByHZAR(sim_L1,GradTable_L1)
write.table(GradTable_L1, 'one_locus_widths.tsv')
# GradTable_L1 <- read.table('one_locus_widths.tsv')

#GradTable_L1 <- GradTable_L1[GradTable_L1$G == 1000,]

pdf('widths_vs_selection_L1.pdf')
GradTable_L1_means <- data.frame(s = numeric(0), b = numeric(0), L1_width_H = numeric(0))

x <-seq(0,1,by=0.01)

plot(x,twidth(x,sqrt(0.5)), type = 'l',
     ylim = c(min(GradTable_L1$width_H), max(GradTable_L1$width_H)),
     xlim = c(min(GradTable_L1$s), max(GradTable_L1$s)),
     xlab = 'selection', ylab = 'width_H')

for(sel in unique(GradTable_L1$s)){
    mw <- mean(GradTable_L1$width_H[GradTable_L1$s == sel])
    GradTable_L1_means <- rbind(GradTable_L1_means, data.frame(s = sel, L1_width_H = mw))
    boxplot(GradTable_L1$width_H[GradTable_L1$s == sel],
            at = sel,
            boxwex = 0.05,
            add = T)
}
dev.off()

GradTable <- ReadSetting('many_loci_setting.txt')
sim <- ReadSummary('many_loci_widths.out')
GradTable <- FillSettingByHZAR(sim,GradTable)
# write.table(GradTable, 'many_loci_widths.tsv')
# GradTable <- read.table('many_loci_widths.tsv')
# GradTable <- GradTable[GradTable$G == 1000,]

GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)
pal <- brewer.pal(10,'RdYlBu')
pdf('multilocus_widths_vs_AUFC_and_generation.pdf')
  PlotStat(GradTable, stat = 'width_H', par1 = 'AUFC', par2 = 'G',
           legend_position = 'topleft', pal = pal, main = 'multilocus cline',
           ylab = 'Cline width', xlab = 'Area under fitness function')
dev.off()

GradTable_L20k_means <- data.frame(s = numeric(0),
                                    b = numeric(0),
                                    width_H = numeric(0),
                                    closest_1L_s = numeric(0))
for(sel in unique(GradTable$s)){
  for(beta in unique(GradTable$b)){
    # mean because some valuas do not converge in first 100 generations,
    # so I wanted to take a meansure with takes into account outlayers
    mw <- mean(GradTable$width_H[GradTable$s == sel & GradTable$b == beta])
    cs <- GradTable_L1_means$s[which.min(abs(GradTable_L1_means$L1_width_H - mw))]
    GradTable_L20k_means <- rbind(GradTable_L20k_means,
                                   data.frame(s = sel,
                                              b = beta,
                                              width_H = mw,
                                              closest_1L_s = cs))
  }
}

GradTable_L20k_means$sss <- GradTable_L20k_means$closest_1L_s / GradTable_L20k_means$s

pal <- brewer.pal(3,'RdYlGn')
pdf('proportion_of_genome_vs_selection.pdf')
  PlotStat(GradTable_L20k_means, stat = 'sss', par1 = 's', par2 = 'b',
           legend_position = 'bottomright', pal = pal, xlab = 's* / S')
dev.off()

#GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)

#pdf('sss_agains_1L_equivalent.pdf')
#PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'b',
#         legend_position = 'topright', pal = pal)
#dev.off()
