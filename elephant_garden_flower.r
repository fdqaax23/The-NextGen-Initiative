# The NextGen Initiative

# Set the working directory
setwd("C:/TheNextGenInitiative/")

# Load the relevant libraries
library(dplyr)
library(ggplot2)
library(caret)
library(leaflet)

# Import the data to the working directory
read.csv("NextGenData.csv", header = TRUE) -> NextGenData

# Summarise the data and explore the structure of the dataset
str(NextGenData)
summary(NextGenData)

# Generate summary statistics
table(NextGenData$Gender)
mean(NextGenData$Age)
mean(NextGenData$Income)

# Visualise the data
ggplot(NextGenData, aes(x=Age, fill=Gender)) + 
  geom_histogram(position="dodge") +
  ggtitle("Age Distribution")

ggplot(NextGenData, aes(x=Income, fill=Gender)) + 
  geom_histogram(position="dodge") +
  ggtitle("Income Distribution")  

# Use leaflet to map the locations of the participants
map <- leaflet(NextGenData) %>%
  addTiles() %>% 
  addMarkers(lng = NextGenData$Longitude,
             lat = NextGenData$Latitude)
map

# Split the data into test and training sets
splitIndex <- createDataPartition(NextGenData$Age, p = 0.80, list = FALSE)
trainData <- NextGenData[ splitIndex,]
testData <- NextGenData[-splitIndex,]

# Build a predictive model
model <- train(Age ~ ., data = trainData, method = 'lm')

# Test the model for its accuracy
predictions <- predict(model, testData)
confusionMatrix(testData$Age, predictions)

# Make predictions on new data points
predict(model, data.frame(Gender = "Female",
                          Income = 30000,
                          Education = "High School"))