# netmetering-solar-investigation
Analysis of net metering data to investigate impact of net metering laws on solar installation. 



## Background

My project drew inspiration from Google's Project Sunroof which allows users to determine the efficacy of installing to the roof of their home of business. In this project, I sought to use Project Sunroof data to investigate solar installation trends. Specifically, I focused on the following questions: 

1) Most broadly, where are solar panels installed? 
  
2) Is there a correlation between sunny weather and installation of solar pannels (which is to be expected)? or can discrepancies in solar installation be attributed to another factor?
  
3) How effective are net metering laws in encouraging solar installation? Different states define net metering using different criteria: how can the effect of these nuances on solar installation help influence policy makers to stress the importance of generous net metering laws? 


## Data 
For this project I used data from two sources: [Google's Project Sunroof](https://sunroof.withgoogle.com/data-explorer/) and [Solar Reviews](https://www.solarreviews.com/blog/the-state-of-net-metering-usa-2021). 


In order to make my preliminary plots, I modified the dataset entitled "sunroof" which contains information about the the Project Sunroof metrics for all US counties covered by project sunroof. First, I eliminated all counties where the estimated number of installed panels was zero and selected six metrics to examine: 

    count_qualified = The number of of buildings in Google Maps that are suitable for solar. 
  
    existing_installs_count = The number of of buildings estimated to have a solar installation, at time of data collection. 
  
    carbon_offset_metric_tons = The potential carbon dioxide abatement of the solar capacity that meets the technical potential criteria. 
  
    number_of_panels_total = The number of solar panels potential for all roof space in that region (assuming 1.650m x 0.992m panels). 
  
    kw_median = kW of solar potential for the median building in that region (assuming 250 watts per panel)
  
    yearly_sunlight_kwh_median =  Project Sunroof's  estimated annual solar energy generation potential for the median roof space in that region. The kWh/kw/yr for the median roof, in DC (not AC) terms. To more easily comprehend the units: kWh produced / kW of panel installed / year. 
  
  I also added the variable `relative_installment` in order to eliminate the variation between county sizes. I used the following calculation: 
  `relative_installment <- existing_installs_count / count_qualified * 100` 
  I use this metric several times throughout my project in order to show how much progress a given county has made with solar installation. 
  
  I added this same variable to the sunroof_states data set, which contains all of the same information as the original sunroof data set for every US state and D.C. instead of by county. I joined sunroof_states with the data to code for a choropleth of the US states. 
  
  
  
To examine net metering, I will be focussing on the following criteria: 

**Definition:** States are in charge of defining methods of compensation for excess energy produced. The way net metering is defined significantly alters the incentive to install solar panels. The most basic net metering policies allow for 1-to-1 credit exchange: if X amount of excess energy is produced in one month, X amount of energy will be compensated for in the next month. Other policies will compensate based on Feed-in Tariffs (FiTs) which consider additional factors such as location, value of solar energy, and retail rates. Depending on the guidelines, FiTs can be more or less generous compared to basic net metering policies. Some states do not allow net metering at all. 

**Coverage:** Some states only allow commercial customers to recieve net metering compensation while others allow for both residential and commercial customers to participate. 

**Virtual Net Metering:** Virtual net metering allows net metering credits to be used across different properties: if property A recieves abundant solar energy, the property owner can use 1-to-1 net metering credits on the energy generated to cover the energy costs of property B. 

**Rollover Policy:** Lenient rollover policies allow for indefinite rollover credit while stricter policies allow for utility companies to reclaim unused credits at the end of each month or year. 

**Demand charges:** Demand charges are utility companies' way of discouraging customers from using sporatic bursts of energy rather than steady consumption. Ultimately demand charges are a disincentive to invest in solar panels because the maximum energy consumed from the grid (typically at night when there is no solar production) is charged and does not reflect their actual usage. 

**Final Grade:** A final grade that consists of combining the aformentioned criteria to come to a consensus in regards to the overall strength of net metering policies in a given state. This final grade was calculated for me in the data set that I used. 


## Shiny Project 
My shiny app has a few additional exploration tools. The purpose of this shiny app was to provide me with an exploratory tool with which I could create the informative plots displayed above. That being said, it is fun to engage with this shiny app, and the app provides information about specific net metering legislation.  

**The Shiny Application contains the following:** 
1) A scatter plot which allows the user to compare two of any of the project sunroof variables that I found to be interesting in the counties of their states of interest. 

2) A choropleth that depicts the scatter plot's x axis per state.

3) A bar chart that uses my calculated variable `weighted_installment` which shows the weighted installment of solar panels per different level of net metering metric. 

4) A choropleth that shows the state by state policy of the chosen net metering metric from the bar chart. 

https://chyman.shinyapps.io/solaranalysis/ 

