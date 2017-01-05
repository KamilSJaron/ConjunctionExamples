#!/bin/bash

conjunction 1> bazykin.out 2> bazykin.err
conjunction settingLM.txt 1> bazykinLM.out 2> bazykinLM.err
Rscript bazykin.R
