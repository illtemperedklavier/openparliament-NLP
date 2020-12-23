# -*- coding: utf-8 -*-
"""
Created on Wed Dec 23 11:45:55 2020

@author: alecr
"""

import pandas as pd

from nltk import word_tokenize

from bs4 import BeautifulSoup

def tokenize_column (row):
    soup = BeautifulSoup(row)
    text = soup.text.lower()
    words = word_tokenize(text)
    return words