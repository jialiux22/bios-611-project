library(shiny)
library(dplyr)

ds_salaries = read.csv("derived_data/salary.csv",row.names = 1)

if_function = function(input,ds_salaries){
  if (input$year != "All"){
    
    ds_salaries = ds_salaries[ds_salaries$work_year == input$year,]
    
  }
  
  if (input$exper_level != "All"){
    
    level = strsplit(input$exper_level," ")[[1]][1]
    
    ds_salaries = ds_salaries[ds_salaries$experience_level == level,]
    
  }
  
  if (input$remote != "All"){
    
    rr = gsub("%","",input$remote)
    
    ds_salaries = ds_salaries[ds_salaries$remote == rr,]
    
  }
  
  if (input$uscom != "All"){
    
    TF = ifelse(input$uscom == "Yes",T,F)
    
    ds_salaries = ds_salaries[ds_salaries$is_us_company == TF,]
    
  }
  
  if (input$size != "All"){
    
    size = strsplit(input$size,"")[[1]][1]
    ds_salaries = ds_salaries[ds_salaries$company_size == size,]
    
  }
  
  ds_salaries = ds_salaries %>% select(work_year,experience_level,employment_type,job_title,remote_ratio,company_location,company_size,salary_in_usd_10K)
  
  return(ds_salaries)
}

ui <- fluidPage(
  
  titlePanel("Select to filter data and visualize the data!!"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "year",
                         label = "Work year",
                         choices = c("All","2020","2021","2022")),
      selectInput(inputId = "exper_level",
                         label = "Experience Level",
                         choices = c("All",
                                     "EN Entry level or Junior",
                                     "MI Mid level or intermediate",
                                     "SE Senior or expert",
                                     "EX Executive-level or director")),
      radioButtons(inputId = "remote",
                  label = "Remote ratio",
                  choices = c("All","0%","50%","100%")),
      radioButtons(inputId = "uscom",
                   label = "Is company located in US?",
                   choices = c("All","No","Yes")),
      radioButtons(inputId = "size",
                   label = "Company Size",
                   choices = c("All","Small (less than 50 employees)",
                               "Medium (50 to 250 employees)",
                               "Large (more than 250 employees)")),
    ),
    
    mainPanel(
      
    
      plotOutput(outputId = "box"),
      tableOutput(outputId = "table")
    )
  )
)


server <- function(input, output) {
  
  
 
  output$box <- renderPlot({
    
    
    ds_salaries = if_function(input = input,ds_salaries =ds_salaries )
    
    boxplot(ds_salaries$salary_in_usd_10K, col = "#75AADB",
         xlab = "",
         main = "Boxplot of salary in USD for filtered data scientists",ylim = c(0,60))
    
  })
  
  output$table = renderTable({
    
   if_function(input = input,ds_salaries =ds_salaries )
    
  })
  
}

shinyApp(ui = ui, server = server)
