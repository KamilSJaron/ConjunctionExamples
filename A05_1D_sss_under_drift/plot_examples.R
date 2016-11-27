library(ConjunctionStats)

sim_D32 <- ReadSummary('setting_D32_HM.out')
GradTable_D32 <- read.table('setting_D32_HM.tsv')
onelocus_HM_D32 <- read.table('setting_onelocus_D32.tsv')
onelocus_HM_D32 <- GetReplicateAverages(onelocus_HM_D32, filter = 1)
GradTable_D32 <- FillClosestS(GradTable_D32, onelocus_HM_D32)

GradTable_D32$width[GradTable_D32$width < 1] <- 1
GradTable_D32$sss <- GradTable_D32$ss / GradTable_D32$s + rnorm(nrow(GradTable_D32), 0, 0.005)
GradTable_D32$s_norm <- GradTable_D32$s + rnorm(nrow(GradTable_D32), 0, 0.007)

for(beta in unique(GradTable_D32$b)){
  for(selection in unique(GradTable_D32$s)){
    base <- paste0('D32b', beta,'s', selection)
    pdf(paste0('cline_',base,'.pdf'))
      which_sims <- which(GradTable_D32$b == beta &
                   GradTable_D32$s == selection &
                   GradTable_D32$G == 100)
      GradSubTable <- subset(GradTable_D32,
                             b == beta & s == selection & G == 100)
      pal <- adjustcolor(brewer.pal(5,'Spectral'), 0.6)
      PlotHybridZone(sim_D32[which_sims], center = GradSubTable,
                   logit = F, col = pal[1], xlim = c(-30,30))
      for(index in 2:5){
        which_sims <- which(GradTable_D32$b == beta &
                     GradTable_D32$s == selection &
                     GradTable_D32$G == index * 100)
        GradSubTable <- subset(GradTable_D32,
                               b == beta & s == selection & G == index * 100)
        PlotHybridZone(sim_D32[which_sims], center = GradSubTable,
                      logit = F, add = T, col = pal[index])
      }
      pal <- adjustcolor(brewer.pal(5,'Spectral'), 1)
      legend('topleft', col = pal, pch = 20, legend = c((1:5) * 100), title = 'Generation')
    dev.off()
  }
}

pdf('clines_on_the_edge_.pdf')
  legend = 1
  par(mfrow = c(3, 3))
  par(cex=1, mar=c(0.35, 0.35, 0.35, 0.35), oma=c(3.5, 4.2, 2, 0))
  # 11 12 13 21 22 23 31 32 33
  # plot
  for(beta in unique(GradTable_D32$b)){
    for(selection in c(0.60,0.65,0.70)){
      base <- paste0('D32b', beta,'s', selection * 10)
      print(base)
      pal <- adjustcolor(brewer.pal(5,'Spectral'), 0.6)
      plot(numeric(0), ylim = c(0,1), xlim = c(-30,30), xaxt='n', yaxt='n')

      if(beta == unique(GradTable_D32$b)[3]){
        axis(side=1,at=seq(-30,30,15),lwd=1)
      }
      if(selection == 0.6){
        axis(side=2,at=seq(0,1,0.5),lwd=1, label = c(0,0.5,1))
      }

      for(index in 1:5){
        which_sims <- which(GradTable_D32$b == beta &
                     GradTable_D32$s == selection &
                     GradTable_D32$G == index * 100)
        GradSubTable <- subset(GradTable_D32,
                               b == beta & s == selection & G == index * 100)
        PlotHybridZone(sim_D32[which_sims], center = GradSubTable,
                      logit = F, add = T, col = pal[index])
      }

      if(beta == unique(GradTable_D32$b)[1]){
        if(selection == 0.60){
          mtext('s', side=3, cex=1.6, adj = 0, line = 0.3)
        }
        mtext(selection, side=3, cex=1, adj = 0.5, line = 0.3)
      }

      if(selection == 0.60){
        if(beta == unique(GradTable_D32$b)[3]){
          mtext(expression(frac(1, 16)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
        if(beta == unique(GradTable_D32$b)[2]){
          mtext(expression(frac(1, 11)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
        if(beta == unique(GradTable_D32$b)[1]){
          mtext(expression(beta), side=3, cex=1.6, adj = -0.45, line = -2)
          mtext(expression(frac(1, 8)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
      }

      if(legend == 9){
        pal <- adjustcolor(brewer.pal(5,'Spectral'), 1)
        legend('bottomright', col = pal, pch = 20, legend = c((1:5) * 100),
               bty = "n", title = 'Generation')
      }
      legend = legend + 1
    }
  }
dev.off()

pdf('logit_clines_on_the_edge_.pdf')
  legend = 1
  par(mfrow = c(3, 3))
  par(cex=1, mar=c(0.35, 0.35, 0.35, 0.35), oma=c(3.5, 4.2, 2, 0))
  # 11 12 13 21 22 23 31 32 33
  # plot
  for(beta in unique(GradTable_D32$b)){
    for(selection in c(0.60,0.65,0.70)){
      base <- paste0('D32b', beta,'s', selection * 10)
      print(base)
      pal <- adjustcolor(brewer.pal(5,'Spectral'), 0.6)
      plot(numeric(0), ylim = c(-10,10), xlim = c(-30,30), xaxt='n', yaxt='n')

      if(beta == unique(GradTable_D32$b)[3]){
        axis(side=1,at=seq(-30,30,15),lwd=1)
      }
      if(selection == 0.6){
        axis(side=2,at=seq(-10,10,10),lwd=1)
      }

      for(index in 1:5){
        which_sims <- which(GradTable_D32$b == beta &
                     GradTable_D32$s == selection &
                     GradTable_D32$G == index * 100)
        GradSubTable <- subset(GradTable_D32,
                               b == beta & s == selection & G == index * 100)
        PlotHybridZone(sim_D32[which_sims], center = GradSubTable,
                      logit = T, add = T, col = pal[index])
      }

      if(beta == unique(GradTable_D32$b)[1]){
        if(selection == 0.60){
          mtext('s', side=3, cex=1.6, adj = 0, line = 0.3)
        }
        mtext(selection, side=3, cex=1, adj = 0.5, line = 0.3)
      }

      if(selection == 0.60){
        if(beta == unique(GradTable_D32$b)[3]){
          mtext(expression(frac(1, 16)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
        if(beta == unique(GradTable_D32$b)[2]){
          mtext(expression(frac(1, 11)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
        if(beta == unique(GradTable_D32$b)[1]){
          mtext(expression(beta), side=3, cex=1.6, adj = -0.45, line = -2)
          mtext(expression(frac(1, 8)), side=3, cex=1, adj = -0.45, line = -5.6)
        }
      }

      if(legend == 9){
        pal <- adjustcolor(brewer.pal(5,'Spectral'), 1)
        legend('bottomright', col = pal, pch = 20, legend = c((1:5) * 100),
               bty = "n", title = 'Gen', cex = 1.2)
      }
      legend = legend + 1
    }
  }
dev.off()
