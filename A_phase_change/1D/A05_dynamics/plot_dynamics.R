library(ConjunctionStats)
library(RColorBrewer)

sim <- ReadSummary('G5000/setting_D32_G5000_edge.out')
GradTable <- read.table('G5000/setting_D32_G5000_edge.tsv')

saves = 100
pal <- brewer.pal(7,'PuBuGn')[-c(1:2)]
pal <- colorRampPalette(pal)(saves)
pal_t <- adjustcolor(pal, 0.6)

pdf('edge_case_cline.pdf')
  which_sims <- which(GradTable$G == 50)
  GradSubTable <- subset(GradTable, G == 50)
  PlotHybridZone(sim[which_sims], center = GradSubTable,
               logit = T, col = pal_t[1], xlim = c(-40,40))
  for(index in 2:saves){
    which_sims <- which(GradTable$G == index * 50)
    GradSubTable <- subset(GradTable, G == index * 50)
    PlotHybridZone(sim[which_sims], center = GradSubTable,
                  logit = T, add = T, col = pal_t[index])
  }
  legend_indexes <- c(1,10,20,30,40,50)
  legend('topleft', col = pal[legend_indexes], pch = 20, legend = legend_indexes * 50, title = 'Generation', bty = "n")
dev.off()

sim <- ReadSummary('G5000/setting_D32_G5000_collapse.out')
GradTable <- read.table('G5000/setting_D32_G5000_collapse.tsv')

pdf('collpasing_cline.pdf')
  which_sims <- which(GradTable$G == 50)
  GradSubTable <- subset(GradTable, G == 50)
  PlotHybridZone(sim[which_sims], center = GradSubTable,
               logit = T, col = pal_t[1], xlim = c(-40,40), main = 'logit collpasing cline')
  for(index in 2:saves){
    which_sims <- which(GradTable$G == index * 50)
    GradSubTable <- subset(GradTable, G == index * 50)
    PlotHybridZone(sim[which_sims], center = GradSubTable,
                  logit = T, add = T, col = pal_t[index])
  }
  legend_indexes <- c(1,10,20,30,40,50)
  legend('topleft', col = pal[legend_indexes], pch = 20, legend = legend_indexes * 50, title = 'Generation', bty = "n")
dev.off()
