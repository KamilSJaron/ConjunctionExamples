library(ConjunctionStats)
library(RColorBrewer)

# sigma^2 = 0.5, D=32
multilocus_HM_D32 <- read.table('multilocus_D32_HM.tsv')
onelocus_HM_D32 <- read.table('one_locus_D32_HM.tsv')
#multilocus_HM_D32 <- GetReplicateAverages(multilocus_HM_D32)
onelocus_HM_D32 <- GetReplicateAverages(onelocus_HM_D32)
multilocus_HM_D32 <- FillClosestS(multilocus_HM_D32, onelocus_HM_D32)

# sigma^2 = 0.25, D=32
multilocus_LM_D32 <- read.table('multilocus_D32_LM.tsv')
onelocus_LM_D32 <- read.table('one_locus_D32_LM.tsv')
#multilocus_LM_D32 <- GetReplicateAverages(multilocus_LM_D32)
onelocus_LM_D32 <- GetReplicateAverages(onelocus_LM_D32)
multilocus_LM_D32 <- FillClosestS(multilocus_LM_D32, onelocus_LM_D32)

# sigma^2 = 0.5, D=16
multilocus_HM_D16 <- read.table('../74_one_locus_widths/multilocus.tsv')
onelocus_HM_D16 <- read.table('../74_one_locus_widths/one_locus_widths.tsv')
#multilocus_HM_D16 <- GetReplicateAverages(multilocus_HM_D16)
onelocus_HM_D16 <- GetReplicateAverages(onelocus_HM_D16)
multilocus_HM_D16 <- FillClosestS(multilocus_HM_D16, onelocus_HM_D16)

multilocus_HM_D32$D <- 32
multilocus_LM_D32$D <- 32
multilocus_HM_D16$D <- 16

multilocus_HM_D32$dispersal <- 0.5
multilocus_LM_D32$dispersal <- 0.25
multilocus_HM_D16$dispersal <- 0.5

multilocus_HM_D32$sss <- multilocus_HM_D32$ss / multilocus_HM_D32$s
multilocus_LM_D32$sss <- multilocus_LM_D32$ss / multilocus_LM_D32$s
multilocus_HM_D16$sss <- multilocus_HM_D16$ss / multilocus_HM_D16$s

GradTable <- rbind(multilocus_HM_D32, multilocus_LM_D32, multilocus_HM_D16)
GradTable$sss <- GradTable$sss + rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)

pdf('sss_vs_sel_beta.pdf')
  pal <- brewer.pal(4,'Spectral')[-3]
  pal <- c(adjustcolor(pal[1], 0.35), adjustcolor(pal[2], 0.65), adjustcolor(pal[3], 0.45))
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = 'bottomright', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(4,'Spectral')[-3]
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
dev.off()

LMcol <- rgb(0.1,0.5,0.5, 0.75)
HMcol <- rgb(0.5,0.5,0.1, 0.75)
pdf('sss_vs_sel_dispersal.pdf')
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'dispersal',
           legend_position = 'bottomright', pal = c(HMcol, LMcol), add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'dispersal',
               pal = c(rgb(0.1,0.5,0.5), rgb(0.5,0.5,0.1)))
dev.off()

pdf('sss_vs_dispersal.pdf')
  hist(multilocus_HM_D32$sss[multilocus_HM_D32$s == 0.65], col = HMcol,
      breaks = 10, main = paste('S* / s ~',expression(sigma^2), 'for s = 0.65'),
      xlim = c(0, 1.6), xlab = 'sss')
  hist(multilocus_LM_D32$sss[multilocus_LM_D32$s == 0.65], col = LMcol,
      breaks = 20, add = T)
  points(mean(multilocus_HM_D32$sss[multilocus_HM_D32$s == 0.65]), -1,
         col = HMcol, pch = 15)
  points(mean(multilocus_LM_D32$sss[multilocus_LM_D32$s == 0.65]), -1,
         col = LMcol, pch = 15)
  legend('topright', c('0.5', '0.25', 'overlap', 'mean'), title = expression(sigma^2), pch = c(rep(20,3),15), col = c(HMcol, LMcol, rgb(0.2,0.4,0.2), 'black'))
dev.off()

D16col <- rgb(0.1,0.1,0.5, 0.75)
D32col <- rgb(0.5,0.1,0.1, 0.75)
pdf('sss_vs_sel_demesize.pdf')
PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'D',
        legend_position = 'bottomright', pal = c(D16col, D32col), add = F,
        xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'D',
             pal = c(rgb(0.1,0.1,0.5), rgb(0.5,0.1,0.1)))
dev.off()

pdf('sss_vs_demesize.pdf')
  hist(multilocus_HM_D16$sss[multilocus_HM_D16$s == 0.65], col = D16col,
       breaks = 20, main = 'S* / s ~ D, for s = 0.65', xlab = 'sss')
  hist(multilocus_HM_D32$sss[multilocus_HM_D32$s == 0.65], col = D32col,
       breaks = 10, add = T)
  points(mean(multilocus_HM_D16$sss[multilocus_HM_D16$s == 0.65]), -1,
         col = D16col, pch = 15)
  points(mean(multilocus_HM_D32$sss[multilocus_HM_D32$s == 0.65]), -1,
         col = D32col, pch = 15)
  legend('topright', c('16', '32', 'overlap', 'mean'), pch = c(rep(20,3),15), col = c(D16col, D32col, rgb(0.6,0.2,0.6), 'black'))
dev.off()

GradTable <- rbind(multilocus_HM_D32, multilocus_LM_D32, multilocus_HM_D16)
GradTable$sss <- GradTable$sss + rnorm(nrow(GradTable), 0, 0.005)
GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b) + rnorm(nrow(GradTable), 0, 0.007)
pdf('sss_vs_AUFC_D.pdf')
  PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'D',
          legend_position = 'bottomleft', pal = c(D16col, D32col), add = F,
          xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
dev.off()

# from sss_vs_AUFC_D we see that we need AUFCs between 0.38 and 0.4 to be on the edge...
# create lots of combinations of selections and beta in whole reasonable range
selelctions <- rep(seq(0.001,1,length = 1000), 1000)
betas <- rep(seq(1, 0.001, length = 1000), each = 1000)
# get their AUFC
AUFCs <- getAUFC(selelctions,betas)

# select those that have AUFC in desired range
AUFCs_chosen <- which(AUFCs > 0.38 & AUFCs < 0.40)
# plot combinaitons of seletions and beta that are in the range
plot(selelctions[AUFCs_chosen] ~ betas[AUFCs_chosen], pch = 20, cex = 0.01)

# we see that for selection in range 0.62 ti 0.9 there is always a range of betas with AUFC in the range
# so for 8 equdistant values in range 0.62 to 0.9 we get a median of betas
# so we see a combinations of selections and betas, that still give AUFC between 0.38 and 0.4 with the
# greatest possible distance of selections / beta, see simulation 77 to find more
for(selection in seq(0.62, 0.9, by = 0.04)){
  print(median(betas[AUFCs_chosen][round(selelctions[AUFCs_chosen], 3) == round(selection,3)][-1]))
}
