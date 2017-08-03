library(ConjunctionStats)

neutral_setting <- ReadSetting('neutral_setting.txt')
neutral_summary <- ReadSummary('neutral_setting.out')

# to package??
factorize_var <- function(setting, var){
    f <- factor(setting[,var])
    levels(f) <- 1:length(unique(setting[,var]))
    return(f)
}

neutral_setting$filenames <- paste0('basic_neutral_L', factorize_var(neutral_setting, 'SL'),
                                    '_n', neutral_setting$n,
                                    '_', factorize_var(neutral_setting, 'G'),
                                    '.tsv')

for(i in 1:nrow(neutral_setting)){
    png(paste0('figures/', neutral_setting$filenames[i], '.png'))
        blocks <- ReadBlocks(neutral_setting$filenames[i])
        gradline <- neutral_setting[i,]
        onesim <- neutral_summary[[i]]
        PlotBlocks(blocks, onesim, gradline)
    dev.off()
}
