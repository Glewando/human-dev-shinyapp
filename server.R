# server.r

shinyServer(
        function(input, output) {
# ********************** Set up all reactive functions first *******************

# --------------- reactive x data corresponding to user selected xvar ----------
        # column number:
                xcolnum <- reactive({as.numeric(input$xvar)})
        # data
                xdata <- reactive({data[,xcolnum()]})
        # column name
                xname <- reactive({names(data[xcolnum()])})

        # Set up chart options for hAxis. title
                hAxis <- reactive({
                        xlab <- paste( "title:", "'", xname(), "'" , sep=" ")
                        paste("{", xlab, "}", sep=" ")
                })

# --------------- reactive y data corresponding to user selected yvar ----------
        # column number:
                ycolnum <- reactive({as.numeric(input$yvar)})
        # data
                ydata <- reactive({data[, ycolnum()]})
        # column name
                yname <- reactive({names(data[ycolnum()])})

# Set up chart options for vAxis of title, minValue & maxValue
                vAxis <- reactive({
                        ylab <- paste( "title:", "'", yname(), "'" , sep=" ")

                        ymin <- trunc(min(ydata())*.8)
                        ylow <-paste("minValue",ymin,  sep=":")

                        ymax <- trunc(max(ydata()) + (max(ydata())*0.05))
                        yhi <- paste( "maxValue", ymax, sep=":")

                        paste("{", ylab, ",", ylow, ",", yhi, "}", sep=" ")
                })

# --------- data for s corresponding to user selected svar ---------------------
        # column number:
                scolnum <- reactive({as.numeric(input$svar)})
        # data
                sdata <- reactive({data[,scolnum()]})
        # column name
                sname <- reactive({names(data[scolnum()])})

# ------------------------------------------------------------------------------
# ******************* Set up the interactive gvisBubbleChart *******************

                output$bubbleplot <- renderGvis({

                # Chart title corresponding to the 3 user selections
                        chtitle <- paste(yname(), "vs.", xname(),
                                        "(bubble size = ",
                                         sname(), ")", sep=" ")

                # set up custom bubble chart options
                        myOpts1 <- list(
                                width="100%", height=700,
                                chartArea = "{left:100, top:50,
                                                width:'75%', height:'75%' }",
                                title = sprintf(chtitle),
                                titleTextStyle = "{fontSize: 20}",
                                # enable user to pan/zoom chart
                                explorer = "{}",
                                bubble="{textStyle:{color: 'none'},
                                        stroke: 'none', opacity: 0.6}",

                                hAxis= hAxis(),
                                vAxis= vAxis()
                                )

                # Generate bubble chart corresponding to the 3 user selections
                        gvisBubbleChart(
                                data = data,
                                idvar= names(data[1]),
                                xvar= xname(),
                                yvar= yname(),
                                sizevar = sname(),
                                colorvar = "Region",
                                chartid = "bubble",
                                options = myOpts1
                                        )

                        })
})
