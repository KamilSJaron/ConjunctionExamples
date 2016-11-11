library(ConjunctionStats)
library(RColorBrewer)

####### Analysis of 2D estimates

ml_diag_1 <- read.table('multilocus_setting_2D_diag.tsv')
ml_diag_2 <- read.table('multilocus_setting_2D_diag2.tsv')
ml_hori_1 <- read.table("multilocus_setting_2D.tsv")
ml_hori_2 <- read.table("multilocus_setting_2D_2.tsv")

selected_cols <- which(substr(colnames(ml_diag_1), 1, 5) == 'width')
z1 <- as.matrix(ml_diag_1[, selected_cols])
z2 <- as.matrix(ml_diag_2[, selected_cols])

z <- z1 - z2
hist(as.vector(z))

selected_cols <- which(substr(colnames(ml_hori_1), 1, 6) == 'width_')
z1 <- as.matrix(ml_hori_1[, selected_cols])
z2 <- as.matrix(ml_hori_2[, selected_cols])

z <- z1 - z2
hist(as.vector(z))

z <- ifelse(z1 > z2, z1, z2)
hist(as.vector(z))
hist(as.vector(z1))
hist(as.vector(z2))

hmean <- function(x){
  length(x) / sum(1 / x, na.rm = T)
}

hist(apply(z, 1, mean) - apply(z, 1, hmean))

# harmonic mean has mostly negligible effect, however in some instances up to 5
# max(z1,z2) is suprisingly conservative, but i do not want to use it since we do not know
# how wrong estimates are for wider zones

# proposed workflow: z1 < filter -> NA
# if(z1 is NA and z2 > 1, replace NA by z2)
# take (method(z1)) as 2D width estimate

Fill2DWidth <- function(GradTable, filter = 1, method = 'hmean', altGradTable = NA){
  selected_cols <- which(substr(colnames(GradTable), 1, 6) == 'width_')
  z <- as.matrix(GradTable[, selected_cols])

  if(!all(is.na(altGradTable))){
    selected_cols <- which(substr(colnames(altGradTable), 1, 6) == 'width_')
    z_alt <- as.matrix(altGradTable[, selected_cols])
    z <- ifelse(z < filter, z, z_alt)
  }

  z[z < filter] <- NA
  if(method == 'hmean'){
    GradTable$width <- apply(z, 1, hmean)
  } else {
    GradTable$width <- apply(z, 1, mean, na.rm = T)
  }
  GradTable$var_width <- apply(z, 1, var, na.rm = T)

  return(GradTable)
}

[5] "onelocus_setting_2D_2.tsv"       "onelocus_setting_2D_diag.tsv"
[7] "onelocus_setting_2D_diag2.tsv"   "onelocus_setting_2D.tsv"




















########### 2D

GratTable_onelocus <- read.table('onelocus_setting_2D.tsv')
GratTable_multilocus <- read.table('multilocus_setting_2D.tsv')

plot(GratTable_onelocus$width_H_1 ~ GratTable_onelocus$total_demes)
plot(GratTable_multilocus$width_H_1 ~ GratTable_multilocus$total_demes)

pdf('deviation_of_width_all.pdf')
  Plot2DZone(GratTable_multilocus)
dev.off()

selected_cols <- which(substr(colnames(GratTable_multilocus), 1, 5) == 'width')
z <- as.matrix(GratTable_multilocus[, selected_cols])
z[z < 1] <- NA
GratTable_multilocus[, selected_cols] <- z

pdf('widths2D_fil.pdf')
  Plot2DZone(GratTable_multilocus, center = F)
dev.off()

GratTable_multilocus$width <- rowMeans(z, na.rm = T)

GratTable_multilocus$width_norm <- GratTable_multilocus$width + rnorm(nrow(GratTable_multilocus), 0, 0.007)
GratTable_multilocus$s_norm <- GratTable_multilocus$s + rnorm(nrow(GratTable_multilocus), 0, 0.007)

pdf('mean_width_vs_selection.pdf')
  PlotStat(GratTable_multilocus, 'width_norm', 's_norm', 'b', ylab = 'mean width', xlab = 'selection')
dev.off()

GratTable_onelocus <- read.table('onelocus_setting_2D.tsv')
selected_cols <- which(substr(colnames(GratTable_onelocus), 1, 5) == 'width')
z <- as.matrix(GratTable_onelocus[, selected_cols])
z[z < 1] <- NA
GratTable_onelocus$width <- rowMeans(z, na.rm = T)
GratTable_onelocus <- GetReplicateAverages(GratTable_onelocus, 'onelocus_average_widths.pdf')

GradTable <- GradTable[GradTable$width_H > 1,]
GradTable <- FillClosestS(GradTable, onelocus_HM_D32)
