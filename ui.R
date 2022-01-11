shinyUI(fluidPage(

    titlePanel("Solar Investigation Application"),

    sidebarLayout(
        sidebarPanel(
            selectInput("varX", "Select Var X to Examine", vars_list, selected="yearly_sunlight_kwh_median"),
            selectInput("varY", "Select Var Y to Examine", vars_list, selected="relative_installment"),
            selectInput("stateSelect", "Pick State to Examine",
                        levels(as.factor(sunroof$state_name)),multiple=TRUE, 
                        selected=c("Florida","Georgia","Arizona","New Mexico")),
            selectInput("varMeter", "Select Net Metering Metric to examine", meter_list, selected="Final_Grade")
            
            
        ),

        mainPanel(
            plotOutput("distPlot"),
            plotOutput("choropleth"), 
            plotOutput("netmeterPlot"),
            plotOutput("netmeterChoropleth")
            )
    )
))


