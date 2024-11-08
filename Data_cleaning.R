#Cleaning the movies dataset to create a 
#set of english movies of a smaller set of genres
library(tidyverse)
library(readr)
library(textcat)
library(stringr)
#Reading in the data:
movies<-read_delim("test_data_solution.txt",delim=":::")
colnames(movies)<-c("row","Movie Name","Genre","Plot")

#Filtering for english movies:
english_indices<-which(textcat(movies$`Movie Name`)=="english")
english_movies<-movies[english_indices,]

#Trimming whitespace on genres to make filtering easier
english_movies$Genre<-str_trim(english_movies$Genre)
english_movies$`Movie Name`<-str_trim(english_movies$`Movie Name`)
#Filtering for genres of interest
genres<-c("western","action",
          "sci-fi","fantasy","history","war","romance","sport")
english_movies_genre<-english_movies |> filter(Genre %in% genres)
english_movies_with_genres<-english_movies_genre

#Writing this out into our final dataset for topic modeling
english_movies_genre<-english_movies_genre |> select(-Genre)
english_movies_genre<-english_movies_genre |> select(-row)
english_movies_genre$`Movie Name`<-gsub("\\(.*", "", english_movies_genre$`Movie Name`)
english_movies_genre$Plot<-paste(english_movies_genre$`Movie Name`,english_movies_genre$Plot,sep = " : ")
write_csv(english_movies_genre,"movie_plots.csv")


#Replicating this with Genres as an 'answer key'
english_movies_with_genres$`Movie Name`<-gsub("\\(.*", "", english_movies_with_genres$`Movie Name`)
english_movies_with_genres$Plot<-paste(english_movies_with_genres$`Movie Name`,english_movies_with_genres$Plot,sep = " : ")
write_csv(english_movies_with_genres,"movie_plots_with_genres.csv")
