library(gridExtra)
library(grid)
library(MASS)

ds_salaries = read.csv("derived_data/salary.csv",row.names = 1)
ds_salaries$remote_ratio = factor(ds_salaries$remote_ratio)

bc = boxcox( lm(salary_in_usd_10K ~  is_22 + experience_level  + remote_ratio  + is_us_company + company_size, ds_salaries),plotit = F)
lambda <- bc$x[which.max(bc$y)]

lm.model = lm(sqrt(salary_in_usd_10K) ~  is_22 + experience_level  + remote_ratio  + is_us_company + company_size, ds_salaries)

png("figure/estimate_table.png",height = 250,width = 400)
grid.table(round(summary(lm.model)$coefficients,digits = 3))
dev.off()

tab.anova = anova(lm.model)
tab.anova = round(tab.anova, digits = 3)

## anova table

png("figure/anova_table.png",width=350, height=150)
grid.table(tab.anova)
dev.off()


## anova plot


png("figure/boxplot1.png")

par(mfrow=c(1,2))

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$is_22, xlab = "Year 2022",ylab = "Salary (in 10K)",main = "After Covid period")

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$experience_level, xlab = "",ylab = "Salary (in 10K)",main = "Experience level")

dev.off()

png("figure/boxplot2.png")

par(mfrow=c(1,3))

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$remote_ratio, xlab = "",ylab = "Salary (in 10K)",main = "Remote ratio")

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$is_us_company, xlab = "",ylab = "Salary (in 10K)",main = "In US company")

boxplot(ds_salaries$salary_in_usd_10K ~ ds_salaries$company_size, xlab = "",ylab = "Salary (in 10K)",main = "Company_size")

dev.off()

## 

set.seed(42)

sample <- sample(c(TRUE, FALSE), nrow(ds_salaries), replace=TRUE, prob=c(0.7,0.3))
train  <- ds_salaries[sample, ]
test   <- ds_salaries[!sample, ]

lm.model = lm(sqrt(salary_in_usd_10K) ~  is_22 + experience_level  + remote_ratio  + is_us_company + company_size, train)

png("figure/predict_plot.png")

plot(test$salary_in_usd_10K, predict(lm.model,test)^2, xlab = "Oberseved", ylab = "Predicted",main = "Test data (Correlation 0.7)")

abline(0,1)

dev.off()


