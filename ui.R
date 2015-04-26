# ui.r

shinyUI(fluidPage(theme = "bootstrap.css",
        titlePanel(h3("2013 Human Development Indicators by World Regions",
                      align="center")),
        br(),

        sidebarLayout(
                sidebarPanel(
                        p("The Human Development Index (HDI) is a summary measure
                        of three central aspects of human development:
                        (1) a long and healthy life, (2) access to knowledge,
                        (3) a decent standard of living. The details for the ",

                # insert hyperlink for the 2014 Technical report
                        a("HDI calculation",
                          href = "http://hdr.undp.org/sites/default/files/hdr14_technical_notes.pdf",
                          target="_blank") ,

                        "and the full ",

                # insert hyperlink for the 2014 Human Development report
                        a("2014 Human Development Report",
                          href= "http://hdr.undp.org/sites/default/files/hdr14-report-en-1.pdf",
                          target="_blank") ,

                        "are available to the public courtesy of the ",

                # insert hyperlink to the Human Development website
                        a("United Nations Development Programme.", href = "http://hdr.undp.org/en",
                          target="_blank")

                        ),

                # introduction to the data exploration application
                p(
                        "This application allows the user to explore how
                        (1) Life Expectancy, (2) Education, and (3) Gross
                        National Income per capita interact to impact HDI. All ",

                # insert hyperlink to the data set
                        a("human devlopment data ", href = "http://hdr.undp.org/en/data",
                          target="_blank") ,
                        "was obtained from the Human Devolpment website."

                ),

                # application instructions
                        p("To explore the data with a bubble chart, select
                        three human development indicators (Y, X, & Z).
                        The bubble chart shows indicator Y as a function of indicator
                        X. Each bubble represents a country. The color indicates
                        world region, and size is the value of indicator Z. The
                        chart title shows your current choices"),


                        p("Hover over a bubble to see the country information."),
                        p("The chart is moveable, zoom-able, and reactive to your
                          choices. So, go ahead- Explore the data!!"),

                selectInput("xvar",
                                label = "HD indicator (X)",
                                choices = c("Life Expectancy" = 4,
                                        "Education Index" = 5,
                                        "Gross National Income (GNI)"= 6
                                ),
                                selected = 5),

                selectInput("yvar",
                                label = "HD indicator (Y)",
                                choices = c("Human Development Rank" = 2,
                                        "Human Development Index"= 3,
                                        "Life Expectancy" = 4,
                                        "Education Index" = 5,
                                        "Gross National Income"= 6
                                ),
                                selected = 3),

                selectInput("svar",
                                label = "HD indicator (Z)",
                                choices = c("Human Development Rank" = 2,
                                        "Human Development Index"= 3,
                                        "Life Expectancy" = 4,
                                        "Education Index" = 5,
                                        "Gross National Income"= 6
                                ),
                                selected = 6)
                        ),




                mainPanel(htmlOutput("bubbleplot"))

        )

))










