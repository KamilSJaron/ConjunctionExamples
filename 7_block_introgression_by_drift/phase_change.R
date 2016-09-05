# # # # # # # # # # # # #
# # #  Phase Change # # #
# # # # # # # # # # # # #

library(ConjunctionStats)

# conjunction drift_blocks_introgression_setting.txt 1> drift_blocks_introgression.out 2> drift_block_introgression.err
# conjunction drift_blocks_introgression_settingBD.txt 1> drift_blocks_introgressionBD.out 2> drift_block_introgressionBD.err
# conjunction setting_introblocks_LM.txt 1> introblocks_LM.out 2> introblocks_LM.err

sim <- ReadSummary('introblocks_HM.out')
GradTable <- ReadSetting('setting_introblocks.txt')
GradTable <- FillSetting(sim,GradTable)

pdf('widths_selection_beta.pdf')
  # epistatic selection plays a role, selection as well
  PlotWidths(GradTable, 's', 'b')
dev.off()

PlotWidths(GradTable, 's', 'D') # drift seems it does not, plot is not saved

ReadSetting('drift_blocks_introgression_setting.txt')
ReadSetting('drift_blocks_introgression_settingBD.txt')
ReadSetting('setting_introblocks_LM.txt')
