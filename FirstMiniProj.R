#1
setwd("C:/Users/Jerry Ann/Documents")
getwd()
pollutantMean <- function(directory, pollutant, id= 1:332){
  
  direct <- list.files("specdata", full.names = TRUE)
  data <- data.frame()
  
  for(i in id){
        data<- rbind(data, read.csv(direct[i]))
        
  }
    mean(data [, pollutant], na.rm= TRUE)
}

##EXAMPLE_OUTPUT
pollutantMean("specdata","sulfate", 1:10)
pollutantMean("specdata","nitrate", 70:72)
pollutantMean("specdata", "nitrate", 23)

#2
complete <- function(directory, id = 1:332){
  
  direct <- list.files("specdata", full.names = TRUE)
  data <- data.frame()
  results <- data.frame(id=numeric(0), nobs=numeric(0))
  
  for(i in id){
    data<-read.csv(direct[i])
    goal.data <- data[(!is.na(data$sulfate)), ]
    goal.data <- goal.data[(!is.na(goal.data$nitrate)), ]
    nobs <- nrow(goal.data)
    results <- rbind(results, data.frame(id=i, nobs=nobs))
    
  }
  results
}
##EXAMPLE_OUTPUT
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete ("specdata", 30:25)
complete ("specdata", 3)

#3

corr <- function(directory, threshold = 0){
  
  direct <- list.files("specdata", full.names = TRUE)
  data <- data.frame()
  cor_output <- numeric(0)
  cases <- complete(directory)
  cases <- cases[cases$nobs>threshold, ] 
  
  
  
  if(nrow(cases)>0){
    for( i in cases$id){
      data<-read.csv(direct[i])
      goal.data <- data[(!is.na(data$sulfate)), ]
      goal.data <- goal.data[(!is.na(goal.data$nitrate)), ]
      sulfate_data <- goal.data["sulfate"]
      nitrate_data <- goal.data["nitrate"]
      cor_output <- c(cor_output, cor(sulfate_data, nitrate_data))
    }
  }
  cor_output
}

##EXAMPLE_OUTPUT
cr <- corr("specdata", 150)
head(cr); summary(cr)
cr <- corr("specdata", 400)
head(cr); summary(cr)
cr <- corr("specdata", 5000)
head(cr); summary(cr);length (cr)
cr <- corr("specdata")
head(cr); summary(cr); length (cr)

#4
getwd()
outcome <- read.csv('outcome-of-care-measures.csv', colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11], main="Hospital 30-Day Death (Mortality) Rates from Heart Attack", xlab="Deaths", ylab="Frequency", col="light blue")

