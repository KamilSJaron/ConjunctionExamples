#!/bin/bash

for i in `seq 1 5`; do
  conjunction setting$i.txt > rotation$i.out 2> log$i.err;
done

Rscript collapsion.R
