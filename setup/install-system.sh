#!/usr/bin/env bash
set -euo pipefail

# Fedora packages for the IME template and VimTeX PDF navigation.
# sudo asks for your password in your own terminal.
sudo dnf --repo=fedora --repo=updates install \
  zathura zathura-pdf-poppler texlive-synctex texlive-hyphen-portuguese \
  texlive-adjustbox texlive-appendix texlive-cancel texlive-contour \
  texlive-datetime2 texlive-datetime2-portuges texlive-datetime2-english \
  texlive-emptypage texlive-epigraph texlive-fewerfloatpages texlive-floatrow \
  texlive-fnpct texlive-fourier texlive-froufrou texlive-fvextra texlive-hyperxmp texlive-imakeidx \
  texlive-libertinus texlive-libertinus-type1 texlive-libertinust1math texlive-lstaddons texlive-makecell \
  texlive-ly1 texlive-microtype texlive-nextpage texlive-pdflscape texlive-pdfpages texlive-pgfgantt \
  texlive-pgfplots texlive-regexpatch texlive-siunitx texlive-soul texlive-soulutf8 \
  texlive-sourcecodepro texlive-sttools texlive-tablefootnote texlive-tcolorbox \
  texlive-textcase texlive-thmtools texlive-tocbibind texlive-todonotes
