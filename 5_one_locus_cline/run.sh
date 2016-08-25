#!/bin/bash

conjunction > bazykin.out 2> bazykin.err
conjunction settingLM.txt > bazykinLM.out 2> bazykinLM.err
Rscript bazykin.R
