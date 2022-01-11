
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
      plot_data<-filter(sunroof, state_name %in% input$stateSelect)
      
      ggplot(plot_data, aes_string(x=input$varX, y=input$varY))+
        geom_point(aes(color=state_name)) +
        theme_classic()+
        labs(title= paste("Relationship between", input$varX, "and",input$varY))
    })
    
    output$choropleth <- renderPlot({
      ggplot()+ 
        geom_polygon(data=sunroof_states,
                     aes_string(x="long", y="lat", group="group", fill=input$varX))+
        coord_map() +
        theme_void()+
        scale_fill_gradient(low="white",high="red")+
        geom_path(data=states, aes(x=long, y=lat, group=group), color="black")+
        labs(title="Geographic Distribution of the X Variable from the Above Plot")

    })
    
    output$netmeterChoropleth <- renderPlot({
      ggplot()+ 
        geom_polygon(data=net_metering_states,
                     aes_string(x="long", y="lat", group="group", fill=input$varMeter), alpha=.9)+
        coord_map() +
        theme_void()+
        scale_fill_brewer(palette = "Spectral", direction=-1, na.translate=F)+
        geom_path(data=states, aes(x=long, y=lat, group=group), color="black")+
        labs(title=paste("Net Metering Geographic Distribution:", input$varMeter))
      

    })
    
    
    output$netmeterPlot <- renderPlot({
      
      summary_net_metering<-summarize(group_by(net_metering_comparison, "choice"=eval(as.name(input$varMeter))),
                                      weighted_installment = sum(existing_installs_count)/sum(count_qualified)
      
      )
      
      ggplot()+
        geom_col(data=summary_net_metering,
                 aes_string(x="choice", y="weighted_installment", fill="choice"))+
        ylab("Percent of Roofs With Panels Installed")+
        scale_y_continuous(expand = c(0,0))+
        scale_fill_brewer(palette = "Spectral", direction=-1, na.translate=F)+
        theme_classic()+
        theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+
        labs(fill=input$varMeter, title=paste("Outcome of Net Metering Policies:", input$varMeter))+
        xlab(input$varMeter)
      
    })
    
})

