# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd

from bs4 import BeautifulSoup

from nltk import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer 
from collections import defaultdict

from gensim import models
import numpy as np

import gensim
from gensim import corpora
from pprint import pprint
import pickle

import spacy

nlp = spacy.load('en_core_web_sm')
df = pd.read_csv(r"D:\data\openparliament\statements_nospeaker_en.csv")
df = df[:30000]
df.drop('Unnamed: 0',axis=1, inplace=True)


max_tokens = 0
count = 0

spacy.prefer_gpu()

vocab_count_dict = defaultdict()

def add(k,v_list):
    if k in vocab_count_dict:
        for v in v_list:
            vocab_count_dict[k].add(v)
    else:
        for v in v_list:
            vocab_count_dict[k] = {v}
            
tot = df.shape[0]  

punctuation = '!"#$%&()*+,-./:;<=>@[]^_`{|}~' + "''"
pun_trans = str.maketrans(dict.fromkeys(punctuation, ' '))
          
#df_chunk = pd.read_csv(r"D:\data\openparliament\statements_nospeaker_en.csv", chunksize=100000)

for index, row in df.iterrows(): 
    soup = BeautifulSoup(row.content_en)
    text = soup.text.lower()
    
    
    text = text.replace('\\n', ' ')
    text = text.replace('—', ' ')
    text = text.replace('   ', ' ')
    text = text.translate(pun_trans)
    
    statement = nlp(text)
    sentence = []
    for token in statement:
        if not (token.is_stop or token.pos ==97 or token.pos ==93):
            if token.pos ==96:
                token = '[name]'    
            elif token.pos ==93:
                token = '[num]'
            
            else:
                token = token.lemma_
    
            sentence.append(token)
    """text = text.translate(pun_trans)
    text = text.replace('\\n', ' ')
    text = text.replace('—', ' ')
    word_tokens = word_tokenize(text)
    tokens = [w for w in word_tokens if not w in stop_words]
    tokens = [t for t in tokens if not t.isdigit()]
    words = [ps.stem(w) for w in tokens]"""
    
    pid = row['politician_id']
    add(pid,sentence)
    
    if len(sentence)>max_tokens:
        max_tokens = len(sentence)
    if count%10000==0:
        print('at row ', count, (count/tot)*100, '% done')
        print('updating id', row['politician_id'], sentence[:10])
    
    
    count+=1
    

with open(r"D:\data\openparliament\models\vocab_dict_large.pkl", "wb") as f:
    pickle.dump(vocab_count_dict, f)