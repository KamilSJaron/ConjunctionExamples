library(ConjunctionStats)
library(RColorBrewer)

# move to permanent functions
source('../scripts/add_alpha.R')
source('../75_effects_of_drift/filling_functions.R')
# sigma^2 = 0.5, D=32
source('../scripts/PlotAverages.R')




GradTable <- read.table('sss_vs_AUFC.tsv')
#                   read.table('../75_effects_of_drift/multilocus_D32_HM.tsv'))
onelocus_HM_D32 <- read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
#GradTable <- getReplicateAverages(GradTable)
onelocus_HM_D32 <- getReplicateAverages(onelocus_HM_D32, 'one_locus_D32_HM_widths.pdf')

GradTable <- fillClosestS(GradTable, onelocus_HM_D32)
GradTable$ss <- NA
for(index in 1:nrow(GradTable)){
  GradLine <- GradTable[index,]
  ss <- onelocus_HM_D32$s[which.min(abs(onelocus_HM_D32$width_H - GradLine$width_H))]
  GradTable$ss[index] <- ss
}

GradTable$sss <- GradTable$ss / GradTable$s +
                         rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
GradTable$b_norm <- GradTable$b + rnorm(nrow(GradTable), 0, 0.007)

pdf('sss_vs_sel_beta.pdf')
  pal <- add.alpha(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = 'bottomright', pal = pal, add = F, xlim = c(0.6,1),
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 's', 'b', pal)
dev.off()

pdf('sss_vs_beta_s.pdf')
  pal <- add.alpha(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'b_norm', par2 = 's',
           legend_position = 'topright', pal = pal, add = F,
           xlab = paste0(expression(beta),' + N(0,0.007)'), ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 'b', 's', pal)
dev.off()

for(sel in unique(GradTable$s)){
 col <- pal[which(sel == unique(GradTable$s))]
 GradTemp <- subset(GradTable, GradTable$s == sel)
 lines(tapply(GradTemp$sss, GradTemp$b, mean) ~ sort(unique(GradTemp$b)), col = col)
 points(tapply(GradTemp$sss, GradTemp$b, mean) ~ sort(unique(GradTemp$b)),
        col = col, pch = 20)
}

GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b +
                  rnorm(nrow(GradTable), 0, 0.008))
pdf('sss_vs_AUFC_beta.pdf')
  pal <- add.alpha(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(subset(GradTable, GradTable$G == 500), stat = 'sss', par1 = 'AUFC',
           par2 = 'b', legend_position = F, pal = pal, add = F,
           xlab = 'AUFC + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- add.alpha(brewer.pal(8,'Spectral'))
  GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)
  PlotAverages(subset(GradTable, GradTable$G == 500), stat = 'sss',
               par1 = 'AUFC', par2 = 'b', pal = pal)
  legend('topright', col = pal, legend = unique(GradTable[,'b']),
         title = expression(beta), pch = 20)
dev.off()
