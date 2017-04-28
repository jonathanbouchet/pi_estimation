library(shiny)
library(ggplot2)
library(gridExtra)

# Define server logic for random distribution application
function(input, output) {

dataOut<-reactive({	
	inside<-0
	val<-c()
	err<-c()
	x_val<-c()
	y_val<-c()
	for (iter in 1:input$n){
		x<-runif(1,0,1.0)
		y<-runif(1,0,1.0)
		if(sqrt(x*x+y*y)<1.0){
			inside<-inside+1
		}
		val[iter]<-((4.0*inside)/iter)
		err[iter]<-(pi-(4.0*inside)/iter)
		x_val[iter]<-x
		y_val[iter]<-y
	}
	res<-data.frame('iter'=rep(1:input$n),'estimation' = val, 'error'= err,'x'=x_val,'y'=y_val)
	#head(res)
  	#return(res)
  	
  })
  
output$estimation <- renderPlot({
	g1<-ggplot(data=dataOut(),aes(x=iter,y=estimation)) + geom_line() + geom_point() + geom_abline(slope=0,intercept=pi,color='red') + xlab('number of points') + ylab('Estimation')
	g2<-ggplot(data=dataOut(),aes(x=estimation)) + geom_histogram(bins=100) + xlim(3,4) + xlab('Estimation distribution') + ylab('Estimation')
	grid.arrange(g1,g2,ncol=2)
})

output$error<- renderPlot({
	p1<-ggplot(data=dataOut(),aes(x=iter,y=error)) + geom_line() + geom_point() + geom_abline(slope=0,intercept=0,color='red') + xlab('number of points') + ylab('Residuals')
	p2<-ggplot(data=dataOut(),aes(x=error)) + geom_histogram(bins=100) + xlim(-1,1) + xlab('Residuals distribution')
	grid.arrange(p1,p2,ncol=2)
})

output$grid <- renderPlot({
	ggplot(data=dataOut(),aes(x=x,y=y,color=ifelse(x*x+y*y<1,'inside','outside'))) + geom_point() + scale_color_manual(name='',values=c(inside="#F21A00",outside="#3B9AB2"))  +xlim(0,1) + ylim(0,1) + theme(legend.position='none')
})   
}
