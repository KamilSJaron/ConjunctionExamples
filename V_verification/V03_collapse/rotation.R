GradTable <- read.table('rotation.tsv')

plot.line <- function(slope = 0.5, intercept = 0, xlim = c(-1,1), ylim = c(-1, 1), add = F, xlab = 'x', ylab = 'y', main = '', lwd = 1){
  x <- c(-5000,5000)
  y <- intercept + (x * slope)
  if(add){
    lines(x,y, lwd = lwd)
  } else {
    plot(x,y,xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab, type = 'l', main = main)
  }
}

GradTable$slope <- GradTable$width / 4
png('./figures/rotation_plot.png')
  plot.line(GradTable$slope[2],
            xlab = 'normalised center of clines',
            ylab = 'slope of cline under logit transform',
            main = 'rotatation of the slope over generations')

  lwds <- rep(seq(1,0.2, length = 100), 5)
  for(i in 3:100){
    plot.line(GradTable$slope[i], add = T, lwd = lwds[i])
  }
  legend('bottomright', lty = 1, lwd = c(1,0.6,0.2), title = 'generation', legend = c(2,50,100))
dev.off()
