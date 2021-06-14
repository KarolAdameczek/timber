import json
import pickle
from sklearn import preprocessing
import pandas as pd
import redis

db = redis.Redis(host="redis-11663.c55.eu-central-1-1.ec2.cloud.redislabs.com",
            port=11663,
            password="saLsk78hHXa6ZnvtP3lz0YM2D3grgdca",
            decode_responses=True)

idx = [
    'A1', 'A8', 'B10', 'B11', 'B13', 'B9', 'C1', 'C2', 'C4', 'C5', 'C9',
    'D10', 'E10', 'E4', 'E6', 'E8', 'F1', 'F3', 'F4', 'F5', 'F7', 'F8',
    'G3', 'G7', 'G8', 'G9', 'H10', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'I1',
    'I2', 'I4', 'I5', 'J1', 'J10', 'J2', 'J3', 'K1', 'K10', 'K2', 'K4',
    'K8', 'K9', 'L1', 'L10', 'L2', 'L4', 'L5', 'L6', 'L7', 'L8', 'L9', 'M1',
    'M5', 'M7', 'N1', 'N10', 'N2', 'N5', 'N6', 'N9', 'O10', 'O2', 'O4',
    'O6', 'O7', 'O8', 'P2', 'P4', 'P6', 'P7'
]

negative = [
    'A8','B10','B11','B9', 'B13', 'C9', 'D10',
    'E8', 'E10', 'F7', 'F8', 'G7', 'G8', 'G9', 
    'H7', 'H8', 'H10', 'J10', 'K10', 'K8', 'K9',
    'L8', 'L9', 'L10', 'M7', 'N10', 'N9', 'O6', 
    'O7', 'O8', 'O10'
]

features_label = ['warmth', 'reasoning', 'emotional_stability', 'dominance', 
           'liveliness', 'rule_consciousness', 'social_boldness',
           'sensitivity', 'vigilance', 'abstractedness',
           'privateness', 'apprehension', 'openness',
           'self_reliance', 'perfectionism', 'tension']

features = [
    ['A1', 'A8'],
    ['B10', 'B11', 'B13', 'B9'],
    ['C1', 'C2', 'C4', 'C5', 'C9'],
    ['D10'],
    ['E10', 'E4', 'E6', 'E8'],
    ['F1', 'F3', 'F4', 'F5', 'F7', 'F8'],
    ['G3', 'G7', 'G8', 'G9'],
    ['H10', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8'],
    ['I1', 'I2', 'I4', 'I5'],
    ['J1', 'J10', 'J2', 'J3'],
    ['K1', 'K10', 'K2', 'K4', 'K8', 'K9'],
    ['L1', 'L10', 'L2', 'L4', 'L5', 'L6', 'L7', 'L8', 'L9'],
    ['M1', 'M5', 'M7'],
    ['N1', 'N10', 'N2', 'N5', 'N6', 'N9'],
    ['O10', 'O2', 'O4', 'O6', 'O7', 'O8'],
    ['P2', 'P4', 'P6', 'P7']
]


def fit_user(request):
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and 'user' in request_json:
        user = request_json['user']
        email = user['email']
    elif request_args and 'user' in request_args:
        user = request_args['user']
        email = user['email']

    # Zmiana indeksów i typów danych
    survey = db.hgetall(f'survey:{email}')
    keys = list(survey.keys())
    for key in keys:
        survey[idx[int(key)]] = int(survey.pop(key))

    # Przekształcenie danch
    df = pd.DataFrame.from_dict({email : survey}, orient='index')
    df = df - 3
    df[negative] = - df[negative]

    # Utworzenie wymiarów
    dim_df = pd.DataFrame()
    for i, l in enumerate(features_label):
        dim_df[l] = df[features[i]].sum(axis=1) / df[features[i]].shape[1]

    # Zapisanie cech do bazy
    db.hmset(f"features:{email}",dim_df.loc[email,:].to_dict())

    # Klasyfikacja użytkownika do grup
    X = preprocessing.normalize(dim_df, axis=1)

    with open('pickled_clusterer.bin', mode='rb') as file:
        model = pickle.load(file)

    value = model.predict(X[0].reshape(1,-1))
    db.sadd(f"cluster:{value[0]}", email)

    # Zebranie danych uzytkownikow z jednego klastra
    members = db.smembers(f"cluster:{value[0]}")
    df = pd.DataFrame(columns=features_label)
    for m in members:
        if m == email:
            continue
        u = db.hgetall(f"features:{m}")
        row = pd.DataFrame.from_dict({m : u}, orient='index')
        df = df.append(row)

    if df.empty:
        return json.dumps({'result' : 0})

    X1 = preprocessing.normalize(df, axis=1)

    # Wyznaczenie partnerow dla nowego uzytkownika
    similarities = X1.dot(X[0]) * 100
    similarities = similarities.round(2)
    partners_set = dict(zip(df.index.tolist(), similarities))
    db.zadd(f"partners:{email}", partners_set)

    # Aktualizacja listy partnerow dla innych uzytkownikow
    for i, e in enumerate(df.index):
        similarity = X1[i].dot(X[0]) * 100
        similarity = similarity.round(2)
        db.zadd(f"partners:{e}", {email : similarity})


    return json.dumps({'result' : 0})
