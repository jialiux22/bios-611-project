FROM rocker/verse
RUN Rscript --no

RUN R -e "install.packages(\"dplyr\")"
RUN R -e "install.packages(\"tinytex\")"
RUN R -e "tinytex::install_tinytex()"
