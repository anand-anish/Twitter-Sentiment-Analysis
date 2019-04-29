#clear the working environment
rm(list=ls())

#set working directory
setwd("C:\\Users\\Anish Anand\\Desktop\\sentiment_analysis")

#load the packages
library(streamR)
library(ROAuth)
library(dplyr)
library(stringr)
library(twitteR)
library(ggplot2)
library(tm)
library(wordcloud)
library(RColorBrewer)

#Accessing the twitter API
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
consumerSecret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
accessToken <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
accessTokenSecret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#handshaking(establishing connection with the twitter app ,to get the tweets)
my_oauth <- OAuthFactory$new(consumerKey = consumerKey, consumerSecret = consumerSecret,requestURL = requestURL, accessURL = accessURL, authURL = authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

#Generate the PIN and paste it the console then run

#getting tweets from twitter
filterStream("tweets.json", track = c("#Modi","#NarendraModi"),timeout = 1600, 
             oauth = my_oauth)
tweets.df <- parseTweets("tweets.json", simplify = TRUE)
write.csv(tweets.df, "tweetsfile1.csv")
#tweets.json is saved in working directory, we will use tweetsfile.csv

#scoring sentiment function
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list or a vector as an "l" for us
  # we want a simple array of scores back, so we use "l" + "a" + "ply" = laply:
  
  scores = laply(sentences, function(sentence, pos.words, neg.words)   
  {  
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

#load sentiment word lists

sent.pos=scan('C:\\Users\\Anish Anand\\Desktop\\positive-words.txt',what='character',comment.char=';')
sent.neg=scan('C:\\Users\\Anish Anand\\Desktop\\negative-words.txt',what='character',comment.char=';')

#add words to list
pos.words= c(sent.pos,'upgrade')
neg.words=c(sent.neg,'wtf','wait','waiting','epicfall','mechanical')


#import the csv file
dataset<-read.csv("tweetsfile1.csv")
dataset$text<-as.factor(dataset$text)

#score all tweets
senti.scores=score.sentiment(dataset$text,pos.words,neg.words, .progress='text')
write.csv(senti.scores,file="C:\\Users\\Anish Anand\\Desktop\\Sentiment_Scores.csv",row.names=TRUE)

#VISUALISING TWEETS

#HISTOGRAM OF sentiment SCORES
hist(senti.scores$score,xlab="Score of tweets",col=brewer.pal(9,"Set3"))
qplot(score,data=senti.scores)

#WORDCLOUD(TEXT MINING)

corpus=Corpus(VectorSource(senti.scores$text))
#convert the text to lower characters
corpus<- tm_map(corpus,tolower)
#remove puntuations,white spaces and  the tweet name itself
corpus<-tm_map(corpus,stripWhitespace)
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,removeWords,c("Modi"))
# Remove stopwords
corpus=tm_map(corpus,function(x) removeWords(x,stopwords()))
# convert corpus to a Plain Text Document
corpus=tm_map(corpus,PlainTextDocument)

#generate the wordcloud
wordcloud(corpus, min.freq=25, scale=c(5,2),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)
===========================================================================================================================================
  