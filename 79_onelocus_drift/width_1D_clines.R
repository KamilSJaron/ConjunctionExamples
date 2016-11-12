library(ConjunctionStats)
library(RColorBrewer)

GradTable_D <- read.table('setting_D.tsv')
GradTable_beta <- read.table('setting_beta.tsv')
GradTable_lambda <- read.table('setting_labda.tsv')

GradTable_D$width_H[GradTable_D$width_H < 1] <- NA

PlotStat(GradTable_D, 'width_H', 's', 'D')
PlotStat(GradTable_beta, 'width_H', 's', 'b')
PlotStat(GradTable_lambda, 'width_H', 's', 'r')

pdf('1L_cline_filtered_widths_vs_demesize.pdf')
  PlotBoxplots(GradTable_D, 'width_H', 's', 'D', 'topright')
dev.off()
# no diff in beta and labmda
PlotBoxplots(GradTable_beta, 'width_H', 's', 'b', 'topright')
PlotBoxplots(GradTable_lambda, 'width_H', 's', 'r', 'topright')

onelocus_HM_D16 <- read.table('../74_one_locus_widths/one_locus_widths.tsv')
onelocus_HM_D32 <- read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
onelocus_HM_D64 <- read.table('../75_effects_of_drift/setting_onelocus_D64.tsv')
onelocus_HM_D128 <- read.table('../75_effects_of_drift/setting_onelocus_D128.tsv')
onelocus_HM_D256 <- read.table('../75_effects_of_drift/setting_onelocus_D256.tsv')
GradTable_L1 <- rbind(onelocus_HM_D16, onelocus_HM_D32, onelocus_HM_D64, onelocus_HM_D128, onelocus_HM_D256)
GradTable_L1$width_H[GradTable_L1$width_H < 1] <- NA

GradTable_D <- GradTable_D[GradTable_D$G < 600,]
GradTable_L1 <- GradTable_L1[GradTable_L1$G < 600,]

GradTable_D <- GradTable_D[GradTable_D$D %in% unique(GradTable_L1$D),]

GradTable_D <- GradTable_D[GradTable_D$s %in% unique(GradTable_L1$s),]
GradTable_L1 <- GradTable_L1[GradTable_L1$s %in% unique(GradTable_D$s),]

GradTable_D <- GradTable_D[!c(GradTable_D$D == 16 & GradTable_D$n > 5),]

dim(GradTable_D)
dim(GradTable_L1)

PlotBoxplots(GradTable_L1, 'width_H', 's', 'D')
PlotBoxplots(GradTable_D, 'width_H', 's', 'D')

colnames(GradTable_L1)[c(9,10)] <- c('width_drift','center_drift')
GradTable <- merge(GradTable_D, GradTable_L1)
dim(GradTable)

GradTable$width_diff <- GradTable$width_H - GradTable$width_drift
PlotBoxplots(GradTable, 'width_diff', 's', 'D')
lines(c(-10,10), c(0,0))
### ok, no weird systematic difference in my simulations

GradTable_D <- read.table('setting_D.tsv')
GradTable_L1 <- rbind(onelocus_HM_D16, onelocus_HM_D32, onelocus_HM_D64, onelocus_HM_D128, onelocus_HM_D256)
GradTable <- rbind(GradTable_D,GradTable_L1)
GradTable$width_H[GradTable$width_H < 1] <- NA

pdf('1L_cline_widths_vs_demesize.pdf',width=12)
  PlotBoxplots(GradTable, 'width_H', 's', 'D', 'topright')
dev.off()
