library(dplyr)

ds_salaries <- read.csv("source_data/ds_salaries.csv",row.names = 1)
                        
ds_salaries = ds_salaries %>% mutate(is_in_us = company_location == "US") %>% mutate(salary_in_usd_10K = salary_in_usd/10000)

write.csv(ds_salaries,"derived_data/salary.csv",quote = F,row.names = F)

png("figure/salary.png")

boxplot(ds_salaries$salary_in_usd_10K, main = "Salary in US Dollar", ylab = "Salary (in 10K)")

dev.off()

png("figure/salary.year.png")

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$work_year, xlab = "Year",ylab = "Salary (in 10K)",main = "Salary ~ Year")

dev.off()