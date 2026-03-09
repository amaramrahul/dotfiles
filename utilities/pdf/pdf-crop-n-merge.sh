#!/bin/sh

# Cropping:
# pdf-quench can be used to graphically crop the pdf page.
# Other similar tools are briss (graphical) and pdfcrop (command-line)

# Merging multiple pages into single page.
# See http://stackoverflow.com/questions/535794/how-can-i-combine-two-pdf-pages-show-up-on-the-same-page
# See http://stackoverflow.com/questions/465271/gluing-imposition-pdf-documents/466110#466110
pdfnup --nup '1x2' --no-landscape --a4paper input.pdf --outfile output.pdf

# Instead of merging multiple pages into single page, If you intend to split
# and merge pdf files and perform other operations on it, then look at pdftk
