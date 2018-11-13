library(tm)
data(acq)

# Basic cleaning
acq <- tm_map(acq, removePunctuation)  
acq <- tm_map(acq, removeNumbers)     
acq <- tm_map(acq, tolower)     
acq <- tm_map(acq, removeWords, stopwords("english"))  
acq <- tm_map(acq, stripWhitespace)   
acq <- tm_map(acq, PlainTextDocument) 

# Split list into words
wrds <- strsplit(paste(unlist(acq), collapse = " "), ' ')[[1]]
# Table
tblWrds <- table(wrds)
Function
GetOccurence <- function(word, table) {
  occurence <- as.data.frame(table)
  occurence <- occurence[grep(word, occurence[,1]), ]
  return(occurence)
}
Modified (full words only)
This function will match the full words only, the solution below capitalises on this answer.

GetOccurence <- function(word, table) {
  occurence <- as.data.frame(table)
  word <- paste0("\\b", word, "\\b")
  occurence <- occurence[grep(word, occurence[,1]), ]
  return(occurence)
}

install.packages("tm")
library(tm)
library(tidyverse)

wolf <- VCorpus(VectorSource(readLines("wolf.txt", encoding = "UTF-8")))
wolf <- tm_map(wolf, removePunctuation)  
wolf <- tm_map(wolf, removeNumbers)     
wolf <- tm_map(wolf, content_transformer(tolower))     
wolf <- tm_map(wolf, removeWords, stopwords("english"))  
acq <- tm_map(acq, stripWhitespace)   
acq <- tm_map(acq, PlainTextDocument) 

View(wolf)


# Install the R text mining packages.  If it's not loaded, you'll have to run this command
# install.packages("tm")
library(tm)

# Set the path to your desktop folder. scripts is where you'll put your text files. Create a new folder within scripts for each movie, named after movie with no spaces.  Replace "nameofmoviefolder" below with name of folder.   
cname <- file.path("~","Desktop","movie-swear", "scripts", "nameofmoviefolder")  

# Build the "corpus" of the one script. This step is required by the text mining package.    
docs <- VCorpus(DirSource(cname))   

# Remove punctuation
docs <- tm_map(docs,removePunctuation)  

# Remove numbers
docs <- tm_map(docs, removeNumbers)

# Make all words lowercase
docs <- tm_map(docs, tolower)   

# Convert it to a "plain text document"
docs <- tm_map(docs, PlainTextDocument)

# Remove "stopwords" -- common words like a, an, or, and
docs <- tm_map(docs, removeWords, stopwords("english"))   

docs <- tm_map(docs, PlainTextDocument)
dtm <- DocumentTermMatrix(docs)   
dtm 
inspect(dtm)
freq <- colSums(as.matrix(dtm))   
length(freq) 
ord <- order(freq)   
m <- as.matrix(dtm)   
dim(m)
write.csv(m, file="DocumentTermMatrix.csv")   

