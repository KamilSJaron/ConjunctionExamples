library(ConjunctionStats)

sim <- ReadSummary('rotation.out')
GradTable <- ReadSetting('setting.txt')
GradTable <- FillSetting(sim,GradTable)

pdf('width_over_time_wo_selection.pdf')
  plot(GradTable$width ~ GradTable$G, pch = 20, ylim = c(0,max(GradTable$width, na.rm = T)), xlab = 'generation', ylab = 'cline width')
  x <- seq(0,100,0.01)
  lines(sqrt(2 * pi * 0.5 * seq(0,100,by = 0.1)) ~ seq(0,100,by = 0.1), col = 'red')
dev.off()

plot.line <- function(slope = 0.5, intercept = 0, xlim = c(-1,1), ylim = c(-1, 1), add = F, xlab = 'x', ylab = 'y', main = '', lwd = 1){
  x <- c(-5000,5000)
  y <- intercept + (x * slope)
  if(add){
    lines(x,y, lwd = lwd)
  } else {
    plot(x,y,xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab, type = 'l', main = main)
  }
}

pdf('rotation_plot.pdf')
  plot.line(GradTable$slope[102],
            xlab = 'normalised center of clines',
            ylab = 'slope of cline under logit transform',
            main = 'rotatation of the slope over generations')

  lwds <- rep(seq(1,0.2, length = 100), 5)
  for(i in 103:200){
    plot.line(GradTable$slope[i], add = T, lwd = lwds[i])
  }
  legend('bottomright', lty = 1, lwd = c(1,0.6,0.2), title = 'generation', legend = c(2,50,100))
dev.off()
