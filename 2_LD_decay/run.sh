#!/bin/bash

conjunction setting_L.txt > out_L 2> err_L
conjunction setting_C.txt > out_C 2> err_C
Rscript LD_decay.R
