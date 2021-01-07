from bs4 import BeautifulSoup
from nltk import word_tokenize, sent_tokenize
from nltk.corpus import stopwords


punctuation = '!"#$%&()*+,-./:;<=>@[]^_`{|}~' + "''"
pun_trans = str.maketrans(dict.fromkeys(punctuation, ' '))

def tokenize(raw_text):
    soup = BeautifulSoup(raw_text)
    text = soup.text.lower()
    text = text.translate(pun_trans)
    text = text.replace('\\n', ' ')
    text = text.replace('—', ' ')
    words = word_tokenize(text)
    return words