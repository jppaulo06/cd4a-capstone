@default_files = ('main.tex');
$pdf_mode = 1;
$out_dir = 'build';
# Check saved files every 200 ms instead of latexmk's 2-second default.
$sleep_time = 0.2;
$pdflatex = 'pdflatex -synctex=1 -file-line-error -interaction=nonstopmode -halt-on-error %O %S';
$pdf_previewer = 'zathura %O %S';
$bibtex_use = 2;
