library(ConjunctionStats)
library(RColorBrewer)

# sigma^2 = 0.5, D=16; move here
multilocus_HM_D16 <- read.table('../74_one_locus_widths/setting_D16_HM.tsv')
onelocus_HM_D16 <- read.table('../74_one_locus_widths/setting_onelocus_D16_HM.tsv')
onelocus_HM_D16 <- GetReplicateAverages(onelocus_HM_D16, filter = 1)
multilocus_HM_D16 <- FillClosestS(multilocus_HM_D16, onelocus_HM_D16)

# sigma^2 = 0.25, D=32; move away,
multilocus_LM_D32 <- read.table('setting_D32_LM.tsv')
onelocus_LM_D32 <- read.table('setting_onelocus_D32_LM.tsv')
onelocus_LM_D32 <- GetReplicateAverages(onelocus_LM_D32, filter = 1)
multilocus_LM_D32 <- FillClosestS(multilocus_LM_D32, onelocus_LM_D32)

for(D in c(32,64,128,256)){
  ml <- read.table(paste0('setting_D',D,'_HM.tsv'))
  onelocus <- read.table(paste0('setting_onelocus_D',D,'.tsv'))
  onelocus <- GetReplicateAverages(onelocus, filter = 1)
  assign(paste0('multilocus_HM_D',D), FillClosestS(ml, onelocus))
}

GradTable <- rbind(multilocus_HM_D16, multilocus_HM_D32,
                   multilocus_HM_D64, multilocus_HM_D128, multilocus_HM_D256)
GradTable$width[GradTable$width < 1] <- 1

#write.table(GradTable, 'filled_drift_GradTable.tsv')

multilocus_LM_D32$dispersal <- 0.25
multilocus_HM_D32$dispersal <- 0.5

### error in estimation (investigate)
multilocus_LM_D32$total_demes <- c()
colnames(multilocus_LM_D32) <- colnames(multilocus_HM_D32)

GradTableDispersal <- rbind(multilocus_LM_D32, multilocus_HM_D32)

### dispersal

GradTableDispersal <- GradTableDispersal[GradTableDispersal$width > 1,]
GradTableDispersal$sss <- GradTableDispersal$ss / GradTableDispersal$s + rnorm(nrow(GradTableDispersal), 0, 0.005)
GradTableDispersal$s_norm <- GradTableDispersal$s + rnorm(nrow(GradTableDispersal), 0, 0.007)
LMcol <- rgb(0.1,0.5,0.5, 0.75)
HMcol <- rgb(0.5,0.5,0.1, 0.75)

# I do not want to observe an effect of deme size, therefore I filter data only
# to subset that contain the same set of the parameters of both simulated disperals
pdf('sss_vs_sel_dispersal.pdf')
  PlotStat(GradTableDispersal, stat = 'sss', par1 = 's_norm', par2 = 'dispersal',
           legend_position = 'bottomright', pal = c(HMcol, LMcol), add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTableDispersal, stat = 'sss', par1 = 's', par2 = 'dispersal',
               pal = c(rgb(0.1,0.5,0.5), rgb(0.5,0.5,0.1)))
dev.off()

pdf('sss_vs_dispersal.pdf')
  hist(GradTableDispersal$sss[GradTableDispersal$s == 0.65 & GradTableDispersal$dispersal == 0.5],
       col = HMcol, breaks = 10, xlim = c(0, 1.6),
       xlab = 'sss', main = 'S* / s ~ dispersal; for s = 0.65')
  hist(GradTableDispersal$sss[GradTableDispersal$s == 0.65 & GradTableDispersal$dispersal == 0.25],
       col = LMcol, breaks = 20, add = T)
  points(mean(GradTableDispersal$sss[GradTableDispersal$s == 0.65 & GradTableDispersal$dispersal == 0.5]),
         -1, col = HMcol, pch = 15)
  points(mean(GradTableDispersal$sss[GradTableDispersal$s == 0.65 & GradTableDispersal$dispersal == 0.25]),
         -1, col = LMcol, pch = 15)
  legend('topright', c('0.5', '0.25', 'overlap', 'mean'),
         title = expression(sigma^2), pch = c(rep(20,3),15),
         col = c(HMcol, LMcol, rgb(0.2,0.4,0.2), 'black'))
dev.off()

### BETA
GradTable$sss <- GradTable$ss / GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable$ss_norm <- GradTable$ss + rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)

pdf('sss_vs_sel_beta.pdf')
  pal <- brewer.pal(4,'Spectral')[-3]
  pal <- c(adjustcolor(pal[1], 0.35), adjustcolor(pal[2], 0.65), adjustcolor(pal[3], 0.45))
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = 'topleft', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(4,'Spectral')[-3]
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
dev.off()

### DEME SIZE
pdf('sss_vs_sel_demesize.pdf')
pal <- adjustcolor(brewer.pal(5,'Spectral'), 0.4)
PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'D',
        legend_position = 'topleft', add = F, pal = pal,
        xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
pal <- brewer.pal(5,'Spectral')
PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'D', pal = pal)
dev.off()

pdf('sss_vs_demesize_s065.pdf')
  library(ggplot2)
  GradTable$D <- as.factor(GradTable$D)
  hist_cut <- ggplot(GradTable, aes(x=sss, fill=D))
  hist_cut + geom_density(alpha = 0.4)
dev.off()

GradTable$AUFC <- GetAUFC(GradTable$s, GradTable$b) + rnorm(nrow(GradTable), 0, 0.007)
pdf('sss_vs_AUFC_D.pdf')
  PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'D',
          legend_position = 'topright', pal = pal, add = F,
          xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
dev.off()

##### sss vs BETA and DEMESIZE

for(beta in unique(GradTable$b)){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_D_b',round(beta,2),'.pdf'))
    pal <- adjustcolor(brewer.pal(5,'Spectral'), 0.4)
    PlotStat(GradTable_subset, stat = 'sss', par1 = 's_norm', par2 = 'D',
            legend_position = 'topleft', add = F, pal = pal,
            xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
    pal <- brewer.pal(5,'Spectral')
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 's', par2 = 'D', pal = pal)
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
