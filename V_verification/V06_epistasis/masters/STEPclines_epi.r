library(ConjunctionStats)

sim <- ReadSummary(list.files(pattern = 'og.out'))
GradTable <- ReadSetting()
GradTable <- FillSetting(sim,GradTable)

n <- 5
palette <- brewer.pal(8,"Spectral")
palette <- palette[c(1,3,6,7,8)]

plot(c(),xlab='centered index',ylab='logit(Hybrid index)',xlim = c(-25,25),ylim = c(-9,9),cex.lab=2, cex.axis=2)
i = 0
for(s in which(GradTable$L == 2)){
	i = i + 1
	sim[[s]]$centered <- sim[[s]]$order - GradTable$center[s]
	ord <- order(sim[[s]]$centered)
	points(logit(meanHI) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
	lines(logit(meanHI[ord]) ~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
}
legend(-25, 9, c(expression(1 / 16),expression(1 / 4),1,4,16), col = palette, pch = 20, title = expression(beta),cex=1)


pdf('Beta_effect_simmula_l2_zoom.pdf')
	par(mar= c(4, 4.3, 0, 0) + 0.5)
	plot(c(),xlab='centered index',ylab='logit(Hybrid index)',xlim = c(-5,5),ylim = c(-5,5),cex.lab=2, cex.axis=2)

	i = 0
	for(s in which(GradTable$L == 2)){
		i = i + 1
		sim[[s]]$centered <- sim[[s]]$order - GradTable$center[s]
		ord <- order(sim[[s]]$centered)
		points(logit(meanHI) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
		lines(logit(meanHI[ord])~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
	}
# 	legend(-23, 8, c(expression(1 / 16),expression(1 / 4),1,4,16), col = palette, pch = 20, title = expression(beta),cex=1.3)
dev.off()

pdf('Beta_effect_simmula_l8.pdf')
	par(mar= c(4, 4.3, 0, 0) + 0.5)
	plot(c(),xlab='centered index',ylab='logit(Hybrid index)',xlim = c(-60,60),ylim = c(-10,10),cex.lab=2, cex.axis=2)

	i = 0
	for(s in which(GradTable$L == 8)){
		i = i + 1
		ord <- order(sim[[s]]$centered)
		points(logit(meanHI) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
		lines(logit(meanHI[ord])~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
	}
# 	legend(-50, 10, c(expression(1 / 16),expression(1 / 4),1,4,16), col = palette, pch = 20, title = expression(beta),cex=1.3)
dev.off()

pdf('Beta_effect_simmula_l8_zoom.pdf')
	par(mar= c(4, 4.3, 0, 0) + 0.5)
	plot(c(),xlab='centered index',ylab='logit(Hybrid index)',xlim = c(-8,8),ylim = c(-5,5),cex.lab=2, cex.axis=2)

	i = 0
	for(s in which(GradTable$L == 8)){
		i = i + 1
		ord <- order(sim[[s]]$centered)
		points(logit(meanHI) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
		lines(logit(meanHI[ord])~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
	}
# 	legend(-50, 10, c(expression(1 / 16),expression(1 / 4),1,4,16), col = palette, pch = 20, title = expression(beta),cex=1.3)
dev.off()

# normalize

pdf('Beta_effect_l8_norm.pdf')
	par(mar= c(4, 4.3, 0, 0) + 0.5)
	plot(c(),xlab='centered index',ylab='logit(Hybrid index) / slope',xlim = c(-8,8),ylim = c(-5,5),cex.lab=2, cex.axis=2)

	i = 0
	slopes <- 2 * sqrt(GradTable$ss) / (sqrt(0.5))

	for(s in which(GradTable$L == 8)){
		i = i + 1
		normC <- slopes[s]
		ord <- order(sim[[s]]$centered)
		points((logit(meanHI) / normC) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
		lines((logit(meanHI[ord]) / normC) ~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
	}

# 		slopes[9] = slopes[9] - 0.2
# 		slopes[10] = slopes[10] - 0.3
# 		normC <- slopes[9]
# 		ord <- order(sim[[9]]$centered)
# 		points((logit(meanHI) / normC) ~ centered, data = sim[[9]], pch = 2,col=1)
# 		lines((logit(meanHI[ord]) / normC) ~ centered[ord], data = sim[[9]], lwd = 2, lty = 2, col=1)
# 		normC <- slopes[10]
# 		ord <- order(sim[[10]]$centered)
# 		points((logit(meanHI) / normC) ~ centered, data = sim[[10]], pch = 3,col=1)
# 		lines((logit(meanHI[ord]) / normC) ~ centered[ord], data = sim[[10]], lwd = 2, lty = 3, col=1)

dev.off()



pdf('Beta_effect_l2_norm.pdf')
	par(mar= c(4, 4.3, 0, 0) + 0.5)
	plot(c(),xlab='centered index',ylab='logit(Hybrid index) / slope',xlim = c(-8,8),ylim = c(-5,5),cex.lab=2, cex.axis=2)

	i = 0
	slopes <- 2 * sqrt(GradTable$ss) / (sqrt(0.5))
	for(s in which(GradTable$L == 2)){
		i = i + 1
		normC <- slopes[s]
		ord <- order(sim[[s]]$centered)
		points((logit(meanHI) / normC) ~ centered, data = sim[[s]], pch = 20,col=palette[i])
		lines((logit(meanHI[ord]) / normC) ~ centered[ord], data = sim[[s]], lwd = 2,col=palette[i])
	}
dev.off()
