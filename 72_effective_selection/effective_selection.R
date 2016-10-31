library(ConjunctionStats)
library(RColorBrewer)

# load simulations with dispersal 0.25 (LM = low migration)
GradTable_LM <- ReadSetting('effective_selection_LM.txt')
sim_LM <- ReadSummary('effective_selection_LM.out')
GradTable_LM <- FillSetting(sim_LM,GradTable_LM)
GradTable_LM <- FillSettingByHZAR(sim_LM,GradTable_LM)

# load simulations with dispersal 0.5 (HM = high migration)
GradTable_HM <- ReadSetting('effective_selection_HM.txt')
sim_HM <- ReadSummary('effective_selection_HM.out')
GradTable_HM <- FillSetting(sim_HM,GradTable_HM)
GradTable_HM <- FillSettingByHZAR(sim_HM,GradTable_HM)

LM_pal <- brewer.pal(7,'Spectral')[1:3]
HM_pal <- brewer.pal(7,'Spectral')[5:7]

x <-seq(0.01,0.99,by=0.01)

plot(x,twidth(x,sqrt(0.5)),type='l',ylim=c(0,max(GradTable_HM$width_l, na.rm=T)),xlab = 's',ylab = 'w')
lines(x,twidth(x,sqrt(0.25)), col = 'red')

for(i in 1:3){
  points(width_l ~ s,pch = 20,
    data=subset(GradTable_HM, GradTable_HM$L == unique(GradTable_HM$L)[i]),
    col=HM_pal[i])
  means_line <- colMeans(matrix(subset(GradTable_HM, GradTable_HM$L == unique(GradTable_HM$L)[i])$width_l, nrow = 5, byrow=T))
  lines(means_line ~ unique(GradTable_HM$s), col=HM_pal[i])
  points(width_l ~ s,pch = 20,
    data=subset(GradTable_LM, GradTable_LM$L == unique(GradTable_LM$L)[i]),
    col=LM_pal[i])
  means_line <- colMeans(matrix(subset(GradTable_LM, GradTable_HM$L == unique(GradTable_LM$L)[i])$width_l, nrow = 5, byrow=T))
  lines(means_line ~ unique(GradTable_HM$s), col=LM_pal[i])
}

legend('topright', legend = unique(GradTable_HM$L), pch = 20, title = 'sigma = 0.5', col = HM_pal)
legend('bottomleft', legend = unique(GradTable_LM$L), pch = 20, title = 'sigma = 0.25', col = LM_pal)
#
#HLEDAME TAKOVE PARAMETRY PRO KTERE SIRKA HYBRIDNI ZONY BUDE ROZUSTNI VUCI POCTU LOKUSU
#
#

# strong selection
GradTable <- ReadSetting('effective_selection_extreme.txt')
sim <- ReadSummary('effective_selection_extreme.out')
GradTable <- FillSetting(sim,GradTable)
GradTable <- FillSettingByHZAR(sim,GradTable)
sim <- FillSummary(sim, GradTable$center_H)

x <-seq(0.01,0.99,by=0.01)
PlotStat(GradTable, stat = 'width_l', par1 = 's', par2 = 'G')

pdf('L1_D16_G500_15REP_widths.pdf')
plot(numeric(0),
     xlim = c(min(GradTable$s),max(GradTable$s)),
     ylim = c(min(GradTable$width_H), max(GradTable$width_H)))
lines(x,twidth(x,sqrt(0.5)), col = 'black')

GradTable_G500 <- GradTable[GradTable$G == 500,]

for(sel in unique(GradTable_G500$s)){
  boxplot(GradTable_G500[GradTable_G500$s == sel,'width_H'],
  add = T, at = sel, boxwex = 0.02)
  points(mean(GradTable_G500[GradTable_G500$s == sel,'width_H']) ~ sel, col = 'red', pch = 20)
}
dev.off()

which.min(GradTable_G500$width_e[!is.na(GradTable_G500$width_e)])
which.min(GradTable_G500$width_l[!is.na(GradTable_G500$width_l)])
which.min(GradTable_G500$width_H)
# 3 23 60

PlotSim(sim[[3]], GradTable[3,])
PlotSim(sim[[23]], GradTable[23,])
PlotSim(sim[[60]], GradTable[60,])


mknAdaA <- hzar.doMolecularData1DPops(distance = 1:20,
    pObs = rep(c(0,1), each=10),
    nEff = rep(512, 20))
#hzar.plot.obsData(mknAdaA);
mknAdaAmodel <- hzar.makeCline1DFreq(mknAdaA, scaling="fixed",tails="none");
mknAdaAmodel <- hzar.model.addBoxReq(mknAdaAmodel,1,20);
mknAdaAmodelFitR <- hzar.first.fitRequest.old.ML(model=mknAdaAmodel ,
                                     mknAdaA,
                                     verbose=FALSE);
mknAdaAmodelFitR$mcmcParam$chainLength <- 2e3;
mknAdaAmodelFitR$mcmcParam$burnin <- 5e2;
mknAdaAmodelFit <- hzar.doFit(mknAdaAmodelFitR)
# plot(hzar.mcmc.bindLL(mknAdaAmodelFit))
mknAdaAmodelData <- hzar.dataGroup.add(mknAdaAmodelFit);
# center, maybe unlist shoud go in the end
unlist(mknAdaAmodelData$ML.cline$param.free[1])
# width
unlist(mknAdaAmodelData$ML.cline$param.free[2])
