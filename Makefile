.PHONY: clean
SHELL: /bin/bash

clean:
	     rm -rf derived_data
			 rm -rf figure
			 rm -f report.pdf

.created-dirs:
	     mkdir -p figure
			 mkdir -p derived_data

derived_data/salary.csv: data_process.R source_data/ds_salaries.csv
			  Rscript data_process.R

figure/estimate_table.png figure/anova_table.png figure/boxplot1.png figure/boxplot2.png predict_plot.png: data_analyze.R derived_data/salary.csv
				Rscript data_analyze.R

report.pdf: figure/estimate_table.png figure/anova_table.png figure/boxplot1.png figure/boxplot2.png predict_plot.png report.Rmd derived_data/salary.csv
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
	

shiny: rshiny.R derived_data/salary.csv
	R -e 'shiny::runApp("rshiny.R", launch.browser = T)'
	