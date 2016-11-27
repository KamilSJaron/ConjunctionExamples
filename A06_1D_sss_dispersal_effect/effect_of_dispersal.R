library(ConjunctionStats)
library(RColorBrewer)

# sigma^2 = 0.25, D=32; move away,
multilocus_LM_D32 <- read.table('setting_D32_LM.tsv')
onelocus_LM_D32 <- read.table('setting_onelocus_D32_LM.tsv')
onelocus_LM_D32 <- GetReplicateAverages(onelocus_LM_D32, filter = 1)
multilocus_LM_D32 <- FillClosestS(multilocus_LM_D32, onelocus_LM_D32)
multilocus_LM_D32$dispersal <- 0.25

multilocus_HM_D32 <- read.table('../A05_1D_sss_under_drift/setting_D32_HM.tsv')
onelocus_HM_D32 <- read.table('../A05_1D_sss_under_drift/setting_onelocus_D32.tsv')
onelocus_HM_D32 <- GetReplicateAverages(onelocus_HM_D32, filter = 1)
multilocus_HM_D32 <- FillClosestS(multilocus_HM_D32, onelocus_HM_D32)
multilocus_HM_D32$dispersal <- 0.5

GradTable <- rbind(multilocus_LM_D32, multilocus_HM_D32)
GradTable <- GradTable[GradTable$width > 1,]

GradTable$sss <- GradTable$ss / GradTable$s

GradTable$sss_norm <- GradTable$ss / GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
LMcol <- rgb(0.1,0.5,0.5, 0.75)
HMcol <- rgb(0.5,0.5,0.1, 0.75)

# I do not want to observe an effect of deme size, therefore I filter data only
# to subset that contain the same set of the parameters of both simulated disperals
pdf('sss_vs_sel_dispersal.pdf')
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'dispersal',
           legend_position = 'bottomright', pal = c(HMcol, LMcol), add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'dispersal',
               pal = c(rgb(0.1,0.5,0.5), rgb(0.5,0.5,0.1)))
dev.off()

pdf('sss_vs_dispersal_hist.pdf')
  hist(GradTable$sss[GradTable$s == 0.65 & GradTable$dispersal == 0.5],
       col = HMcol, breaks = 10, xlim = c(0, 1.6),
       xlab = 'sss', main = 'S* / s ~ dispersal; for s = 0.65')
  hist(GradTable$sss[GradTable$s == 0.65 & GradTable$dispersal == 0.25],
       col = LMcol, breaks = 20, add = T)
  points(mean(GradTable$sss[GradTable$s == 0.65 & GradTable$dispersal == 0.5]),
         -1, col = HMcol, pch = 15)
  points(mean(GradTable$sss[GradTable$s == 0.65 & GradTable$dispersal == 0.25]),
         -1, col = LMcol, pch = 15)
  legend('topright', c('0.5', '0.25', 'overlap', 'mean'),
         title = expression(sigma^2), pch = c(rep(20,3),15),
         col = c(HMcol, LMcol, rgb(0.2,0.4,0.2), 'black'))
dev.off()
