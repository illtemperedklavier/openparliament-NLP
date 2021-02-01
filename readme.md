"frequency distributions.ipynb"

counts usages of different words in the text statements
uses a simple tokenizer and doesn't elimate punctuation and stopwords
dict saved to models for faster processing next time

# Context

Combating the climate crisis is the definitive existential challenge of this time, and the 2018 Nobel Prize in economics was won by Nordhaus and Romer (US), who proved that carbon pricing would be an effective strategy for combatting climate change. Since that is a matter of federal policy, there are public transcripts of government proceedings, and I specialize in NLP, I'm seeing what I can see with the government and political data I have access to. This is a very perfunctory initial look at what I found. The data I'm using here is from openparliament.ca, which makes tracking the progress of bills through government easy, and provides the Hansard transcipts of House sittings*. 

For this, I used proceedings from sessions between Jan 1 2000, and August 2020. Since the Canadian parliament has statements in both official languages, I isolated the English statements. Statements made by the Speaker in the capacity as the Speaker tend to be very standardized and are just part of the procedure, so I removed them.


 
# Vocabulary Counting

Counting the size of vocabularies for members of parliament from Jan 1 2000 to Sep 20th 2020. For this, I wanted to avoid overcounting vocabularies by including proper names, so I used the "en-core-web-sm" pretrained module from SpaCy to identify the parts of speech, and excluded punctuation, stopwords, and proper nouns. 

 
##Hypothesis Testing - do liberals or conservatives have larger vocabularies?


# Topic Modeling

Gensim LDA/LSI

BERTopic

