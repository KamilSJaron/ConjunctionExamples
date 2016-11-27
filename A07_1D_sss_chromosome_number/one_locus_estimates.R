library(ConjunctionStats)

#sigma^2 = 0.5, D=32
onelocus_1 <- read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
onelocus_2 <- read.table('../80_sss_vs_C/setting_L1.tsv')
onelocus_3 <- read.table('../79_onelocus_drift/setting_labda.tsv')
onelocus_4 <- read.table('../75_effects_of_drift/one_locus_D32_HM_new_estimate.tsv')

onelocus_2$LogL <- c()
onelocus_4$LogL <- c()

onelocus_1$run <- 1
onelocus_2$run <- 2
onelocus_3$run <- 3
onelocus_4$run <- 4

onelocus <- rbind(onelocus_1, onelocus_2, onelocus_3, onelocus_4)
PlotBoxplots(onelocus, 'width', 's', 'run', 'topright')

GradTable <- ReadSetting('../75_effects_of_drift/one_locus_setting_HM.txt')
sim <- ReadSummary('../75_effects_of_drift/one_locus_HM.out')

GradTable$width <- NA
GradTable$center <- NA
GradTable$LogL <- NA

for(i in 1:nrow(GradTable)){
  AdaA <- SummaryToHZAR(sim[[i]], GradTable[i,])
  AdaAmodelData <- FitHZARmodel(AdaA, 'none', BoxReq = c(0, nrow(AdaA$frame)),
                                burnin = 1e3, chainLength = 5e3);

  # center
  GradTable$center[i] <- unlist(AdaAmodelData$ML.cline$param.free[1])
  # width
  GradTable$width[i] <- unlist(AdaAmodelData$ML.cline$param.free[2])
  # log likelihood
  GradTable$LogL[i] <- AdaAmodelData$ML.cline$logLike
}

#write.table(GradTable[,1:10], '../75_effects_of_drift/one_locus_D32_HM_BoxRex1_nrow.tsv')

onelocus_5 <- read.table('../75_effects_of_drift/one_locus_D32_HM_BoxRex0_nrow.tsv')
onelocus_5$run <- 5
onelocus_6 <- read.table('../75_effects_of_drift/one_locus_D32_HM_BoxRex1_nrow.tsv')
onelocus_6$run <- 6

onelocus <- rbind(onelocus_1, onelocus_5, onelocus_6)
PlotBoxplots(onelocus, 'width', 's', 'run', 'topright')
