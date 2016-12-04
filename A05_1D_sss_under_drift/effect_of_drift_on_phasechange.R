library(ConjunctionStats)
library(RColorBrewer)

GradTable <- data.frame()
for(D in c(16,32,64,128,256)){
  if(D == 32){
    # this simulation was already performed in A04
    ml <- read.table('../A04_1D_sss/setting_D32.tsv')
    onelocus <- read.table('../A04_1D_sss/setting_onelocus_D32.tsv')
  } else {
    ml <- read.table(paste0('setting_D',D,'.tsv'))
    onelocus <- read.table(paste0('setting_onelocus_D',D,'.tsv'))
  }
  onelocus <- GetReplicateAverages(onelocus, filter = 1)
  GradTable <- rbind(GradTable, FillClosestS(ml, onelocus))
}

GradTable$width[GradTable$width < 1] <- 1

#write.table(GradTable, 'filled_drift_GradTable.tsv')
GradTable <- FillSss(GradTable)

pal <- brewer.pal(3,'Spectral')
pdf('sss_vs_sel_beta.pdf')
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
           legend_position = 'topleft', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
dev.off()

### DEME SIZE
Dpal <- brewer.pal(5,'RdYlGn')
t_Dpal <- adjustcolor(Dpal, 0.4)

pdf('sss_vs_sel_demesize.pdf')
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'D',
          legend_position = NA, add = F, pal = t_Dpal,
          xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'D', pal = Dpal)
  legend('topleft', title = 'D', legend = unique(GradTable$D), pch = 20, col = Dpal, bty = "n")
dev.off()

pdf('sss_vs_demesize_s065.pdf')
  library(ggplot2)
  GradTable$D <- as.factor(GradTable$D)
  hist_cut <- ggplot(GradTable, aes(x=sss, fill=D))
  hist_cut + geom_density(alpha = 0.4)
dev.off()

GradTable$AUFC_norm <- GetAUFC(GradTable$s, GradTable$b) + rnorm(nrow(GradTable), 0, 0.007)
pdf('sss_vs_AUFC_D.pdf')
  PlotStat(GradTable, stat = 'sss_norm', par1 = 'AUFC_norm', par2 = 'D',
          legend_position = 'topright', pal = Dpal, add = F,
          xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
dev.off()

##### sss vs BETA and DEMESIZE

for(beta in unique(GradTable$b)){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_D_b',round(beta,2),'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'D',
            legend_position = 'topleft', add = F, pal = t_Dpal,
            xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 's', par2 = 'D',
                 pal = Dpal, plot_sd = T, epsilon = 0.002)
    title(main = paste(expression(beta),beta))
  dev.off()
}

# # from sss_vs_AUFC_D we see that we need AUFCs between 0.38 and 0.4 to be on the edge...
# # create lots of combinations of selections and beta in whole reasonable range
# selelctions <- rep(seq(0.001,1,length = 1000), 1000)
# betas <- rep(seq(1, 0.001, length = 1000), each = 1000)
# # get their AUFC
# AUFCs <- getAUFC(selelctions,betas)
#
# # select those that have AUFC in desired range
# AUFCs_chosen <- which(AUFCs > 0.38 & AUFCs < 0.40)
# # plot combinaitons of seletions and beta that are in the range
# plot(selelctions[AUFCs_chosen] ~ betas[AUFCs_chosen], pch = 20, cex = 0.01)
#
# # we see that for selection in range 0.62 ti 0.9 there is always a range of betas with AUFC in the range
# # so for 8 equdistant values in range 0.62 to 0.9 we get a median of betas
# # so we see a combinations of selections and betas, that still give AUFC between 0.38 and 0.4 with the
# # greatest possible distance of selections / beta, see simulation 77 to find more
# for(selection in seq(0.62, 0.9, by = 0.04)){
#   print(median(betas[AUFCs_chosen][round(selelctions[AUFCs_chosen], 3) == round(selection,3)][-1]))
# }

#### 1L check
# onelocus_HM_D16 <- read.table('../74_one_locus_widths/one_locus_widths.tsv')
# onelocus_HM_D32 <- read.table('one_locus_D32_HM.tsv')
# onelocus_HM_D64 <- read.table('setting_onelocus_D64.tsv')
# onelocus_HM_D128 <- read.table('setting_onelocus_D128.tsv')
# onelocus_HM_D256 <- read.table('setting_onelocus_D256.tsv')
#
# GradTable_L1 <- rbind(onelocus_HM_D16, onelocus_HM_D32, onelocus_HM_D64, onelocus_HM_D128, onelocus_HM_D256)
# GradTable_L1 <- GradTable_L1[GradTable_L1$width > 1,]
# PlotBoxplots(GradTable_L1, 'width', 's', 'D')
