library(tidyverse)
library(shiny)
library(rsconnect)
library(maps)
library(mapproj)

states<-map_data("state")

metadata<-read_csv("metadata.csv")

sunroof<-read_csv("project-sunroof-county.csv")
sunroof<-filter(sunroof, existing_installs_count>0) 
sunroof<- select(sunroof, region_name, state_name, 
                 yearly_sunlight_kwh_median, 
                 existing_installs_count, 
                 count_qualified, 
                 number_of_panels_total, 
                 carbon_offset_metric_tons, 
                 kw_median) 

sunroof<-mutate(sunroof, relative_installment = existing_installs_count/count_qualified*100) 

vars_list <- colnames(sunroof)
vars_list<-vars_list[c(3:9)]

net_metering<-read_csv("net_metering_by_state (3).csv")
net_metering<-rename(net_metering, "region"="State")
net_metering$region<-tolower(net_metering$region)
net_metering_states<-full_join(states,net_metering,by="region")

sunroof_states<-read_csv("project-sunroof-state.csv")
sunroof_states<-mutate(sunroof_states, relative_installment = existing_installs_count/count_qualified*100) 

sunroof_states$region<-tolower(sunroof_states$region_name)
net_metering_comparison<-inner_join(sunroof_states,net_metering, by="region")

sunroof_states$region<-tolower(sunroof_states$region_name)
sunroof_states<-left_join(states,sunroof_states,by="region")


meter_list<-colnames(net_metering)
meter_list<-meter_list[2:7]

net_metering_comparison<-select(net_metering_comparison, region, all_of(vars_list), all_of(meter_list))

northeast_states<- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "New Jersey", "New York", "Pennsylvania")
midwest_states <- c("Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota")
south_states <- c("Delaware", "Florida", "Georgia", "Maryland", "North Carolina", "South Carolina", "Virginia", "District of Columbia", "West Virginia", "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", "Louisiana", "Oklahoma", "Texas")
west_states <- c("Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", "Washington")

net_metering_comparison<- mutate(net_metering_comparison, us_region=ifelse(region %in% tolower(northeast_states), "Northeast",
                                        ifelse(region %in% tolower(midwest_states), "Midwest",
                                               ifelse(region %in% tolower(south_states), "South",
                                                      ifelse(region %in% tolower(west_states), "West","NA")))))


regional_rates <- summarize(group_by(net_metering_comparison, us_region),
                            weighted_installment = sum(existing_installs_count)/sum(count_qualified),
                            )

