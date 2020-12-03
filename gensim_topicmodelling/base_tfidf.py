import pandas as pd
from bs4 import BeautifulSoup
from nltk import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from gensim import models
import gensim
from gensim import corpora
from pprint import pprint

punctuation = '!"#$%&\'()*+,-./:;<=>@[\\]^_`{|}~'

df_chunk = pd.read_csv(r"D:\data\openparliament\statements_nospeaker_en.csv", chunksize=10000)

content_en_list = []  

def tokenize_column (row):
    soup = BeautifulSoup(row)
    text = soup.text.lower()
    words = word_tokenize(text)
    return words

stop_words = set(stopwords.words('english'))

def remove_stopwords(word_tokens):
    words = [w for w in word_tokens if not w in stop_words]
    words = [w for w in word_tokens if not w in punctuation]
    return words


for chunk in df_chunk:  
    chunk_filter = chunk.drop(['Unnamed: 0'], axis=1)
    chunk_filter = chunk.content_en
    print(type(chunk_filter))
    chunk_filter = chunk_filter.apply(tokenize_column)
    chunk_filter = chunk_filter.apply(remove_stopwords)
    print('done')
    content_en_list.append(chunk_filter)

df_concat = pd.concat(content_en_list)
utterances = df_concat

dict = corpora.Dictionary(utterances)

print(dict)

corpus = [dict.doc2bow(line) for line in utterances]

tfidf = models.TfidfModel(corpus, smartirs='ntc')

tfidf.save(r"D:\data\openparliament\models\tfidf2")