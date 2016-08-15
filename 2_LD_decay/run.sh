#!/bin/bash

conjunction setting_L > out_L 2> err_L
conjunction setting_C > out_C 2> err_C
Rscript LD_decay.R
