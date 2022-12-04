library(dplyr)

ds_salaries <- read.csv("source_data/ds_salaries.csv",row.names = 1)

ds_salaries = ds_salaries %>% 
  mutate(is_us_company = company_location == "US") %>% 
  mutate(salary_in_usd_10K = salary_in_usd/10000) %>%
  mutate(is_FT = employment_type == "FT") %>% 
  mutate(is_us_person = employee_residence == "US") %>%
  mutate(is_22 = work_year == "2022")

write.csv(ds_salaries, "derived_data/salary.csv")

