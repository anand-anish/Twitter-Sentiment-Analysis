# Twitter Sentiment Analysis

## Business Problem/Objective

#### Sentiment Data:
Unstructured data on opinions, emotions and attitudes contained in sources like social media, blogs, online product reviews and customer support interactions  

#### Potential Uses of Sentiment Data
Organizations use sentiment analysis to understand how the public feels about something at a particular moment in time, and also to track how those opinions change over time.  An enterprise may analyse sentiment about:  
 A product – For example, does the target segment understand and appreciate messaging around a product launch? What products do visitors tend to buy together, and what are they most likely to buy in the future?
A service – For example, a hotel or restaurant can look into its locations with particularly strong or poor service.
Competitors – In what areas do people see our company as better than (or weaker than) our competition?
Reputation – What does the public really think about our company? Is our reputation positive or negative?  

In this project, we will focus on a famous personality review(Reputation). Specifically, we will look at public sentiment as of what people feel about the current Prime Minister of India, Mr. Narendra Modi.   
Subsequent score and wordcloud has to be generated corresponding to it. 

#### APPROACH
 
Every time we release a product or service, we want to receive feedback from users so as to know what they like and what they don’t. Sentiment Analysis can help us regarding that. Moreover, the sentiment analysis is also beneficial across all domains, whether it is for movie reviews, or product launch, or even for political parties.The political parties use this, so as to know better as of what the people’s grievances or complaints are. In fact, they use these analysis to know better about the reputation of their leader among the people.In the subsequent analysis, I have done sentiment analysis using twitter data on Mr. Narendra Modi.
The basic approach was to get the twitter data and have a list of positive and negative words on the other side.
The comparison of tweet words with the dictionary will let us know if the sentiment is positive or not.
We shall use a basic scoring criteria for calculating the overall sentiment in a tweet, like
              Positive Sentiment = +1
              Negative Sentiment = -1
              Neutral Sentiment = 0
The overall count will let us know if the sentiment of people regarding the topic is positive, negative or neutral .
