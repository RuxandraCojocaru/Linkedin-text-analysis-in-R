# Installing and loading the packages

if(!require("quanteda")) {install.packages("quanteda"); library("quanteda")}
if(!require("quanteda.textstats")) {install.packages("quanteda.textstats"); library("quanteda.textstats")}
if(!require("readtext")) {install.packages("readtext"); library("readtext")}
if(!require("tidyverse")) {install.packages("tidyverse"); library("tidyverse")}
if(!require("RColorBrewer")) {install.packages("RColorBrewer"); library("RColorBrewer")}
if(!require("corpus")) {install.packages("corpus"); library("corpus")}
if(!require("tm")) {install.packages("tm"); library("tm")}
if(!require("RWeka")) {install.packages("RWeka"); library("RWeka")}
if(!require("tidyr")) {install.packages("tidyr"); library("tidyr")}
if(!require("textmineR")) {install.packages("textmineR"); library("textmineR")}
if(!require("tidytext")) {install.packages("tidytext"); library("tidytext")}
if(!require("topicmodels")) {install.packages("topicmodels"); library("topicmodels")}
if(!require("reshape2")) {install.packages("reshape2"); library("reshape2")}
if(!require("wordcloud")) {install.packages("wordcloud"); library("wordcloud")}
if(!require("wordcloud2")) {install.packages("wordcloud2"); library("wordcloud2")}
if(!require("igraph")) {install.packages("igraph"); library("igraph")}
if(!require("ggraph")) {install.packages("ggraph"); library("ggraph")}
if(!require("factoextra")) {install.packages("factoextra"); library("factoextra")}
if(!require("widyr")) {install.packages("widyr"); library("widyr")}
if(!require("stats")) {install.packages("stats"); library("stats")}
if(!require("readr")) {install.packages("readr"); library("readr")}
if(!require("ldatuning")) {install.packages("ldatuning"); library("ldatuning")}
if(!require("stm")) {install.packages("stm"); library("stm")}
if(!require("readxl")) {install.packages("readxl"); library("readxl")}
if(!require("visNetwork")) {install.packages("visNetwork"); library("visNetwork")}
if(!require("networkD3")) {install.packages("networkD3"); library("networkD3")}

# Setting the working directory
setwd('/files')

# Reading the files
data <- readtext("*.txt") 
data$doc_id<-str_sub(data$doc_id, 1, str_length(data$doc_id)-4)
data <- data[order(as.integer(data$doc_id)),]
rownames(data) <- NULL

# Creating corpus data type
my.corpus <- corpus(data)
docvars(my.corpus, "Number") <- sprintf("%02d", 1:ndoc(my.corpus))
my.corpus

# Create the summary statistics of corpus file
my.corpus.stats <- summary(my.corpus, n = 842)
my.corpus.stats$Text <- reorder(my.corpus.stats$Text, 1:ndoc(my.corpus), order = T)
my.corpus.stats %>%
  arrange(desc(Types))


# Document Feature Matrices (DFMs)
# Create dfm from corpus + data preparation + stop words
my.dfm <- dfm(my.corpus, remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove =c(stopwords("english")))
my.dfm <- dfm(my.dfm,remove = c("â","s","1","2","al","et","also","may","4","6","10","can","will","given", "us", "new", "based", "etc", "today","day", "weâ","youâ","please", "across", "great", "per", "days", "looking", "re", "ll", "ðÿ","c","ms", "via", "e.g", "nice", "just", "one", "like", "things", "de", "qa", "siemens", "itâ"))
# DFM sorted by prevalent features
head(dfm_sort(my.dfm, decreasing = TRUE, margin = "both")) 
topfeatures(my.dfm) # basic word frequencies
word.frequencies <- textstat_frequency(my.dfm) # more elaborate frequencies
head(word.frequencies, 20)
 

# Visualizing DFMs
wordcloud2(word.frequencies, color = "random-dark", backgroundColor = "white",size = 0.5, shape = "triangle")
wordcloud2(word.frequencies)


# Tidy the data set
data_continut <- data %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# Customize some stopwords 
my_stop_words <- bind_rows(stop_words, 
                           tibble(word = c("â", "s","1","2","al","et","also","may","4","6","10","can","will","given", "us", "new", "based", "etc", "today","day", "weâ","youâ","please", "across", "great", "per", "days", "looking", "re", "ll", "ðÿ","c","ms", "via", "e.g", "nice", "just", "one", "like", "things", "de", "qa", "siemens", "itâ"), 
                                  lexicon = "custom"))

data_continut<- data_continut %>%
  anti_join(my_stop_words)

rownames(data_continut) <- NULL


# Content word pairs 
continut_word_pairs <- data_continut %>% 
  pairwise_count(word, doc_id, sort = TRUE, upper = FALSE)

continut_word_pairs %>%
  filter(n >= 250) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n), edge_colour = "cyan4") +
  geom_node_point(size = 5) +
  geom_node_text(aes(label = name), repel = TRUE, 
                 point.padding = unit(0.2, "lines")) +
  theme_void()

# Content word correlations
continut_word_cors <- data_continut %>% 
  anti_join(my_stop_words) %>%
  group_by(word) %>%
  filter(n() >= 100) %>%
  pairwise_cor(word, doc_id, sort = TRUE, upper = FALSE)

continut_word_cors %>%
  filter(correlation > .4) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation, edge_width = correlation), edge_colour = "royalblue") +
  geom_node_point(size = 5) +
  geom_node_text(aes(label = name), repel = TRUE,
                 point.padding = unit(0.2, "lines")) +
  theme_void()


#BI-GRAMS
linkedin_bigrams <- data %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
linkedin_bigrams   #pairs of common words

#Eliminating stop words
bigrams_separated <- linkedin_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% my_stop_words$word) %>%
  filter(!word2 %in% my_stop_words$word)

bigrams_united <- bigrams_filtered %>%
  unite(bigram, word1, word2, sep = " ")
bigrams_united    #pairs of uncommon words


#Bigram counts: most used word pairs 
bigram_counts <- bigrams_filtered %>% 
  count(word1, word2, sort = TRUE)
bigram_counts

#Trigram counts
data %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  filter(!word1 %in% my_stop_words$word,
         !word2 %in% my_stop_words$word,
         !word3 %in% my_stop_words$word) %>%
  count(word1, word2, word3, sort = TRUE)

#Analysing bigrams
bigrams_filtered %>%
  filter(word2 == "skills") %>%
  count( word1, sort = TRUE) #types of skills wanted
skills <-bigrams_filtered %>%filter(word2 == "skills") %>%count( word1, sort = TRUE)

bigrams_filtered %>%
  filter(word2 == "language") %>%
  count( word1, sort = TRUE) #most searched for languages
languages<-bigrams_filtered %>%filter(word2 == "language") %>%count( word1, sort = TRUE)

bigrams_filtered %>%
  filter(word2 == "people") %>%
  count( word1, sort = TRUE) #preffered types of personality 

bigrams_filtered %>%
  filter(word1 == "receive") %>%
  count( word2, sort = TRUE) #what is being offered by companies

bigrams_filtered %>%
  filter(word1 == "deliver") %>%
  count( word2, sort = TRUE) #what is being asked of students

bonuses <-bigrams_filtered %>%
  filter(word1 == "bonus") %>%
  count( word2, sort = TRUE) #types of bonuses

bigrams_filtered %>%
  filter(word1 == "free") %>%
  count( word2, sort = TRUE) #types of facilities


#Visualizing a network of bigrams with ggraph
bigram_graph <- bigram_counts %>%
  filter(n > 30) %>%
  graph_from_data_frame()

bigram_graph
library(ggraph)
set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  theme_void()


#Topic modelling
my_stop_words <- bind_rows(stop_words, 
                           tibble(word = c("â", "s","1","2","al","et","also","may","4","6","10","can","will","given", "us", "new", "based", "etc", "today","day", "weâ","youâ","please", "across", "great", "per","des", "days", "looking", "re", "ll", "ðÿ","c","ms", "via", "e.g", "nice", "just", "one", "like", "things", "de", "qa", "siemens", "itâ", "und","en","les","la", "ã", "team", "skills", "experience", "business", "customer", "customers", "development", "knowledge", "process", "software", "support", "data", "environment"), 
                                  lexicon = "custom"))

word_counts <- data_continut %>%
  anti_join(my_stop_words) %>%
  count(doc_id, word, sort = TRUE) %>%
  ungroup()

desc_dtm <- word_counts %>%
  cast_dtm(doc_id, word, n)

desc_dtm

desc_lda <- LDA(desc_dtm, k = 4, control = list(seed = 1234))
desc_lda


tidy_lda <- tidy(desc_lda)
tidy_lda

top_terms <- tidy_lda %>%
  group_by(topic) %>%
  slice_max(beta, n = 8, with_ties = FALSE) %>%
  ungroup() %>%
  arrange(topic, -beta)
top_terms


top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  group_by(topic, term) %>%    
  arrange(desc(beta)) %>%  
  ungroup() %>%
  ggplot(aes(beta, term, fill = as.factor(topic))) +
  geom_col(show.legend = FALSE) +
  scale_y_reordered() +
  labs(title = "Top 8 terms in each LDA topic",
       x = expression(beta), y = NULL) +
  facet_wrap(~ topic, ncol = 4, scales = "free")



#Excel MetaData analysis
library(ggplot2)
library(dplyr)
library("readxl")
my_data <- read_excel('data.xlsx')

#LOCATION
location.freq = table(my_data$Location)
location.df <- as.data.frame(location.freq)

ggplot(location.df, aes(x=Var1, y=Freq)) + 
  geom_bar(stat = "identity",fill = "lightblue", color = "black") +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.position="none") +
  xlab("Locations") + 
  ylab("Jobs available") 


#REMOTE
remote.freq = table(my_data$Remote)
remote.df <- as.data.frame(remote.freq)

# Compute the percent for piechart
remote.df <- remote.df %>% 
  arrange(desc(Var1)) %>%
  mutate(prop = Freq / sum(remote.df$Freq) *100)

ggplot(remote.df, aes(x = "", y =prop, fill = Var1)) +
  geom_col(color = "black") +
  geom_text(aes(label = paste0(format(round(prop, 2), nsmall = 2),'%' ) ),
            position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y") +
  scale_fill_brewer() +
  theme_void()


#TYPE + POSITION
counts <- table(my_data$Type, my_data$Position)
type.df <- as.data.frame(counts)

ggplot(type.df, aes(fill=Var1, y=Freq, x=Var2)) + 
  geom_bar(position="stack", stat="identity")+
  xlab("Positions") + 
  ylab("Jobs available") +
  theme_bw()+
  scale_fill_brewer()


#INDUSTRY
counts <- table(my_data$Industry)
industry.df <- as.data.frame(counts)

ggplot(industry.df, aes(x=Var1, y=Freq)) + 
  geom_bar(stat = "identity",fill ='lightblue' , color = "black") +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  theme(axis.text = element_text(face="bold"))+
  theme(legend.position="none") +
  xlab("Locations") + 
  ylab("Jobs available") 


