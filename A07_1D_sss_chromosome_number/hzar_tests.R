library(ConjunctionStats)

GradTable <- ReadSetting('setting_C5.txt')
sim <- ReadSummary('setting_C5.out')

i <- 1
AdaA <- SummaryToHZAR(sim[[i]], GradTable[i, ])

mirror <- list()
no_tails <- list()

ptm <- proc.time()
for(i in 1:50){
  AdaAmodelData <- FitHZARmodel(AdaA, "mirror")
  mirror[[i]] <- AdaAmodelData
  AdaAmodelData <- FitHZARmodel(AdaA, "none")
  no_tails[[i]] <- AdaAmodelData
}
time100est <- proc.time() - ptm

GradTable <- read.table('setting_C5.tsv')

getWidth <- function(AdaAmodelData){ return(AdaAmodelData$ML.cline$param.free$width) }
getIsValid <- function(AdaAmodelData){ return(AdaAmodelData$ML.cline$isValid) }
getLogLike <- function(AdaAmodelData){ return(AdaAmodelData$ML.cline$logLike) }
getTable <- function(mirror){
  return( data.frame(width = unlist(lapply(mirror, getWidth)),
                     is_valid = unlist(lapply(mirror, getIsValid)),
                     logLike = unlist(lapply(mirror, getLogLike))))
}

mirror <- getTable(mirror)
no_tails <- getTable(no_tails)
mirror_blue <- rgb(0,0,1, alpha = 0.3)
none_red <- rgb(1,0,0, alpha = 0.3)

pdf('width_estimates.pdf')
  plot(mirror$width ~ mirror$logLike, pch = 20,
       xlim = c(min(c(mirror$logLike, no_tails$logLike)),
                max(c(mirror$logLike, no_tails$logLike))), col = mirror_blue)

  points(no_tails$width ~ no_tails$logLike, pch = 20, col = none_red)
  legend('topright', pch = 20, c('mirror', 'none'), col = c(mirror_blue,none_red))
dev.off()

##### likelihood power test


onelocus <- read.table('setting_L1.tsv')
means <- GetReplicateAverages(onelocus, filter = 0)
multilocus <- read.table('setting_C5.tsv')
ml_means <- GetReplicateAverages(multilocus, filter = 0)

multilocus$mean_dev <- NA
for(beta in unique(multilocus$b)){
  for(selection in unique(multilocus$s)){
    rows <- which(multilocus$s == selection & multilocus$b == beta)
    multilocus$mean_dev[rows] <- multilocus$width[rows] -
                                 subset(ml_means, s == selection & b == beta)$width
  }
}


##### plot logit clines

GradTable <- read.table('setting_C5.tsv')
PlotHybridZone(sim[1:10], center = GradTable[1:10,], logit = T, add = F)


i <- 10
AdaA <- SummaryToHZAR(sim[[i]], GradTable[i, ])

mirror <- list()
no_tails <- list()

AdaAmodelData <- FitHZARmodel(AdaA, "mirror", c(0, nrow(sim[[i]])))
mirror[[i]] <- AdaAmodelData
AdaAmodelData <- FitHZARmodel(AdaA, "none")
no_tails[[i]] <- AdaAmodelData
