

# preform simulation and create a version file
.PRECIOUS : %.out
%.out : %.txt version
	conjunction $< 1> $@ 2> $*.err

version:
	conjunction -v > version

# compute widths; the variable COMP_WIDTHS has to be defined
%.tsv : %.out
	$(COMP_WIDTHS) $*

## print help
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

## clean everything
.PHONY : clean
clean :
	-@rm -rf sims/*tsv sims/*err sims/*out 2>/dev/null || true
	-@rm -rf figures/* 2>/dev/null || true
	-@rm -rf version 2>/dev/null || true
