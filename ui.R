library(shiny)

fluidPage(
    
titlePanel("Pi estimation with MC method"),

sidebarLayout(
sidebarPanel(
	sliderInput("n", 
	"Number of random points:", 
	value = 500,
	min = 1, 
	max = 10000),
	helpText("Considering a circle/square unit"),
	helpText("Estimation is given by the formula : pi = 4*N_inside / N_outside"),
	helpText("explanation :",a("here",href="https://academo.org/demos/estimating-pi-monte-carlo/")),
	hr(),
	hr(),
	br(),
	h5("contact :", a("Jonathan Bouchet", href = "bouchetjonathan@gmail.com"))
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Estimation", plotOutput("estimation")), 
        tabPanel("Error", plotOutput("error")), 
        tabPanel("2D plot", plotOutput("grid",width = "750px",height="750px"))
      )
    )
  )
)
