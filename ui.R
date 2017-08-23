#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("NDC Breakdown"),
  sidebarPanel(
    fileInput('file1', 'Choose CSV File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
    tags$hr(),
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=','),
                 'Comma'),
    radioButtons('quote', 'Quote',
                 c(None=''),
                 'Double Quote'),
    selectInput("dataset", "Choose a dataset:", 
                choices = c("General Statistics", "Predictive Statistics","Daily Report - Drug Totals", "Daily Report - Manufacturer Totals", "Example to Upload")),
    downloadButton('downloadData', 'Download')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Upload Display",tableOutput('data_display')),
      tabPanel("General Statistics",
               tableOutput('general_statistics_display')),
      tabPanel("NDC Manufacturer Info",
               selectInput("NDC_Manufacturer_Range", "NDC Manufacturer Ranges:",
                           c("Cylinders" = "cyl",
                             "Transmission" = "am",
                             "Gears" = "gear")),
               plotOutput("NDC_Manufacturer_Plot"),
               tableOutput("NDC_Manufacturer_Display")),
      tabPanel("NDC Drug ID Info",
               selectInput("NDC_Drug_Range", "NDC Drug Ranges:",
                           c("Cylinders" = "cyl",
                             "Transmission" = "am",
                             "Gears" = "gear")),
               plotOutput("NDC_Drug_ID_Plot"),
               tableOutput("NDC_Drug_ID_Display"))
    )
  )
))