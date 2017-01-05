library(ConjunctionStats)
library(RColorBrewer)

GradTable <- read.table('setting_beta_effects.tsv')
sim <- ReadSummary('setting_beta_effects.out')

G_pal <- colorRampPalette(brewer.pal(7,'PuBuGn'))(12)[-c(1:2)]
pal_t <- adjustcolor(G_pal, 0.6)

for(beta in unique(GradTable$b)){
  for(L in unique(GradTable$L)){
    pdf(paste0('cline_b_',beta,'_L_', L ,'.pdf'))
      plot(numeric(0), xlim = c(-40,40), ylim = c(-8,8), xlab = 'deme index', ylab = 'logit mean hybrid index',
           main = paste('L',L,expression(beta),beta))
      for(index in 1:10){
        which_sims <- which(GradTable$b == beta &
                     GradTable$G == index * 100 & GradTable$L == L)
        PlotHybridZone(sim[which_sims], center = 'start',
                      logit = T, add = T, col = pal_t[index])
      }

      legend('topleft', col = G_pal, pch = 20, legend = c((1:10) * 100), title = 'Generation', bty = "n")
    dev.off()
  }
}

gradline <- GradTable[100,]
onesim <- sim[[100]]
onesim <- tail(head(onesim, -30), -30)
PlotHybridZone(list(onesim), center = 'start', logit = T, add = F)
hzar_model <- SummaryToHZAR(onesim, gradline)
hzar.plot.obsData(hzar_model)
model <- FitHZARmodel(hzar_model, tails = 'mirror', burnin=10000, chainLength=20000)
GradTable$center[100] <- unlist(model$ML.cline$param.all$center)
GradTable$width[100] <- unlist(model$ML.cline$param.all$width)

hzartab <- hzar.doMolecularData1DPops(distance = onesim$order,
        pObs = onesim$meanHI, nEff = rep(gradline$D, nrow(onesim)))
hzarmodel <- hzar.makeCline1DFreq(hzartab, scaling="fixed",tails="mirror");
hzarmodel <- hzar.model.addBoxReq(hzarmodel,0,100);
hzarmodelfitR <- hzar.first.fitRequest.old.ML(model=hzarmodel ,hzartab, verbose=FALSE);
hzarmodelfitR$mcmcParam$chainLength <- 2e3;
hzarmodelfitR$mcmcParam$burnin <- 5e2;
hzarmodelfit <- hzar.doFit(hzarmodelfitR)

plot(hzar.mcmc.bindLL(hzarmodelfit))
hzarmodeltdata <- hzar.dataGroup.add(hzarmodelfit);
## Not run:
hzarmodeltdata <- hzar.dataGroup.add(hzarmodeltdata,
                                     hzar.chain.doSeq(hzar.next.fitRequest(hzarmodelfit)));
hzar.plot.cline(mknAdaAmodelData);
hzar.plot.fzCline(mknAdaAmodelData);

getSlope(onesim,gradline)
getCenter(onesim,gradline)

pal <- brewer.pal(5,'Spectral')
for(L in c(2,8)){
  pdf(paste0('G1000_L_', L ,'.pdf'))
  plot(numeric(0), xlim = c(-40,40), ylim = c(-8,8),
       xlab = 'deme index', ylab = 'logit mean hybrid index',
       main = paste('L',L))
  for(beta in unique(GradTable$b)){
    index <- which(beta == unique(GradTable$b))
    which_sims <- which(GradTable$b == beta &
                 GradTable$G == 1000 & GradTable$L == L)
    PlotHybridZone(sim[which_sims], center = GradTable[which_sims,],
                  logit = T, add = T, col = pal[index])
  }
  legend('topleft', col = pal, pch = 20,
         legend = unique(GradTable$b), title = expression(beta), bty = "n")
  dev.off()
}
