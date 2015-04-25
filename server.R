# server.r

shinyServer(
        function(input, output) {
        # data for x corresponding to user selected xvar
                x <- reactive({
                        data[,as.numeric(input$xvar)]
                })

        # data for y corresponding to user selected yvar
                y <- reactive({
                        data[, as.numeric(input$yvar)]
                })

        # data for s corresponding to user selected svar (size variable)
                s <- reactive({
                        data[, as.numeric(input$svar)]
                })

        # y axis label, reactive to changing yvar input
                yl <- reactive({
                        switch(input$yvar,
                               "2" = "Human Development Rank",
                               "3" = "Human Development Index",
                               "4" = "Life Expectancy",
                               "5" = "Education Index",
                               "6" = "Gross National Income per capita"
                        )
                })

        # x axis label, reactive to changing xvar input
                xl <- reactive({
                        switch(input$xvar,
                               "4" = "Life Expectancy",
                               "5" = "Education Index",
                               "6" = "Gross National Income per capita"
                        )
                })

        # Set the x axis limits corresponding to the xvar choosen
                xmin <- reactive({
                        min = min(x())
                })

                xmax <- reactive({
                        max = max(x()) + (max(x())*0.05)
                })

        # Set the y axis limits corresponding to the yvar choosen
                ymin <- reactive({
                        min = min(y())
                })

                ymax <- reactive({
                        max = max(y()) + (max(y())*0.05)
                })


        #Sets the chart title based on the selections of xvar and yvar
                chtitle <- reactive({
                        paste(yl(), "vs.", xl() ,sep=" ")
                })


        # output of the interactive bubble chart
                output$bubbleplot <- renderGvis({

                        # Set up the variables for the reactive data.frame
                        idv <- names(data[1])
                        x <- names(data[as.numeric(input$xvar)])
                        y <- names(data[as.numeric(input$yvar)])
                        s <- names(data[as.numeric(input$svar)])

                        # Set up the hAxis parameters of title, minValue & maxValue
                        xlab <- paste( "title:", "'", xl(), "'" , sep=" ")
                        xlow <- paste( "minValue:", "'", xmin(), "'" , sep=" ")
                        xhi <- paste( "maxValue:", "'", xmax(), "'" , sep=" ")
                        xAxis <- paste("{", xlab, ",", xlow, ",", xhi, "}", sep=" ")

                        # Set up the vAxis parameters of title, minValue & maxValue
                        ylab <- paste( "title:", "'", yl(), "'" , sep=" ")
                        ylow <- paste( "minValue:", "'", ymin(), "'" , sep=" ")
                        yhi <- paste( "maxValue:", "'", ymax(), "'" , sep=" ")
                        yAxis <- paste("{", ylab, ",", ylow, ",", yhi, "}", sep=" ")

                        # set up custom bubble chart options
                        myOpts1 <- list(
                                width="100%", height=700,
                                chartArea = "{left:100, top:50, width:'75%', height:'75%' }",
                                title = sprintf(chtitle()),
                                titleTextStyle = "{fontSize: 20}",
                                # enable user to pan/zoom chart
                                explorer = "{}",
                                bubble="{textStyle:{color: 'none'},
                                        stroke: 'none', opacity: 0.6}",
                                hAxis= xAxis,
                                vAxis= yAxis
                                )

                        # Generate the bubble chart corresponding to the user
                        # selected variables
                        gvisBubbleChart(
                                data = data,
                                idvar= idv,
                                xvar= x,
                                yvar= y,
                                sizevar = s,
                                colorvar = "Region",
                                chartid = "bubble",
                                options = myOpts1
                                        )

                        })

})
