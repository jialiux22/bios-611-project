.PHONY: clean
SHELL: /bin/bash

clean:
	     rm -rf derived_data
			 rm -rf figure
			 rm -f report.pdf

.created-dirs:
	     mkdir -p figure
			 mkdir -p derived_data

derived_data/salary.csv figure/salary.png figure/salary.year.png: data_process.R source_data/ds_salaries.csv
			  Rscript data_process.R

report.pdf: figure/salary.png figure/salary.year.png
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
