# bios-611-project

## Data
Data science job salary data: https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries?resource=download&select=ds_salaries.csv

## Introduction
Nowadays, students in the university tend to consider data science as their majors. Because of the high salary, the jobs of data scientist and data engineer become much more hot when new graduates are finding jobs. We are interested in finding the potential factors making impacts on the salary of data scientist and data engineer and making the model to learn how important for those factors to make some effects on the salary of those jobs. Therefore, we choose a data of the salary of data scientist and data engineer from Kaggle. It also includes some potential factors which may have some impacts on the salary. We would build the regression model of some potential factors on the salary amount, find the significance of those potential factors, and interpret the factors.

## Use the docker

Build the docker image by typing:
```
docker build . -t proj611
```

And then start an RStudio by typing:

```
docker run -v $(pwd):/home/rstudio -p 8787:8787 -e PASSWORD=123
```

### Use makefile to generate the file

1. Clean the previous data and directory:

```
make clean
```

2. Create the directory:

```
make .created-dirs
```

3. Use data_process to generate the figure and processed data:

```
make derived_data/salary.csv figure/salary.png figure/salary.year.png
```

4. Generate the report:

```
make report.pdf
```
