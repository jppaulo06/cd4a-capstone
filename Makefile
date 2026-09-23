.PHONY: pdf watch clean

pdf:
	latexmk

watch:
	latexmk -pvc -view=none

clean:
	latexmk -c
