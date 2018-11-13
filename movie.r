# Install the R text mining packages.  If it's not loaded, you'll have to run this command
# install.packages("tm")
library(tm)

# Set the path to your desktop folder. scripts is where you'll put your text files. Create a new folder within scripts for each movie, named after movie with no spaces.  Replace "nameofmoviefolder" below with name of folder.   
cname <- file.path("~","Desktop","movie-swear", "scripts")  

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

# Again convert it to a "plain text document"
docs <- tm_map(docs, PlainTextDocument)

# Stem common endings from words 
docs <- tm_map(docs, stemDocument)   

# Again convert it to a "plain text document"
docs <- tm_map(docs, PlainTextDocument)

# Strip whitespace 
docs <- tm_map(docs, stripWhitespace)

# Again convert it to a "plain text document"
docs <- tm_map(docs, PlainTextDocument)

# Create a Matrix from the document. 
dtm <- DocumentTermMatrix(docs)   

# Prep for export to Excel
m <- as.matrix(dtm)   

# Transpose rows and columns
m <- t(m)   

# Write out to csv. change the name. 
write.csv(m, file="wolf.csv")   

