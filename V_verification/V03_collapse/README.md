# Colapsion

"Migration: across a chain of demes migration should cause a step to collapse to a cline with width sqrt(2 * π * σ^2 * t)"

This is a test of correct implementation of stepping stone model with m = ½. We show that simulation is doing a random walk, when the expansion is without selection disrupted only by drift. Therefore the first few generations are perfectly matching expectations, but longer walk is, more error of the drift accumulates. Therefore single simulations are not matching expectation well after several tens of generations. However, overall average of five simulations is matching expectation perfectly, since the walk is random and the accumulated error as well [Figure](expected_output/width_over_time_wo_selection.pdf).

One could think about the phenomena as rotation of the slope of the cline under logit transformation. The angle of rotation will decrease with square root of time, since the slope is proportional to inverse of the cline width as it is shown on (Figure)[./expected_output/rotation_plot.pdf].
