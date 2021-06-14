from flask import Flask, render_template, redirect, request, g
from functools import wraps

from bcrypt import hashpw, checkpw, gensalt
from dotenv import load_dotenv
from os import getenv

from redis import StrictRedis
from jwt import encode, decode
from datetime import timedelta, datetime
from requests import post
from json import dumps

from survey import *
from validation import *

load_dotenv()
REDIS_HOST = getenv('REDIS_URL')
REDIS_PASS = getenv('REDIS_PASS')
JWT_SECRET = getenv('JWT_SECRET')
REDIS_PORT = getenv('REDIS_PORT')
ML_URL = getenv('ML_URL')

db = StrictRedis(host=REDIS_HOST, port=REDIS_PORT, db=0, password=REDIS_PASS)

SESSION_TYPE = "redis"
SESSION_REDIS = db
app = Flask(__name__)

def checkPassword(login, password):
    try:
        pw = db.hget("user:" + login, "password")
    except Exception:
        return None
    else:       
        return checkpw(password.encode(), pw)

def check_if_user_exists(user):
    try:
        print(b"user:" + user.encode())
        print(db.hexists("user:" + user, "password"))
        return db.hexists("user:" + user, "password")
    except Exception:
        return False

def generate_token(login):
    try:
        name = db.hget("user:" + login, "name")
        survey = False
        if db.keys("survey:" + login):
            survey = True
        payload = {
            'usr':login,
            'name':name.decode(),
            'survey':survey,
            'exp': datetime.utcnow() + timedelta(minutes=30),
            'iss':'timber'
        }
        token = encode(payload, JWT_SECRET, algorithm = 'HS256')
        req_data = {"user" : {"email" : payload['usr']}}
        if survey:
            print("WYSYŁAM POSTA DO ML: ")
            print(req_data)
            post(ML_URL, data=dumps(req_data), headers={"Content-Type":"application/json"})
        return token
    except Exception:
        return None

def get_user_name(email):
    try:
        name = db.hget("user:" + email, "name")
        return name.decode()
    except:
        return "Błąd bazy danych"

def get_drag_and_drop(email):
    try:
        result = db.hget("user:" + email, "drag_and_drop")
        result = result.decode().split(',')
        result_text = []
        for o in result[:2]:
            result_text.append(PRIORITIES[int(o)])
        return ", ".join(result_text)
    except:
        return "Błąd bazy danych"

def get_love_type(email):
    try:
        result = db.hget("user:" + email, "love_type")
        return LOVE_TYPES[int(result.decode())]
    except:
        return "Błąd bazy danych"

def get_gender(email):
    try:
        result = db.hget("user:" + email, "gender")
        return result.decode()
    except:
        return "Błąd bazy danych"

def get_interest(email):
    try:
        result = db.hget("user:" + email, "interest")
        return result.decode()
    except:
        return "Błąd bazy danych"

def auth_needed(func):
    @wraps(func)
    def inner(*args, **kwargs):
        auth = True

        exp_date = g.authorization.get('exp')
        iss = g.authorization.get('iss')
        user = g.authorization.get('usr')

        if exp_date is None or user is None or iss is None:
            auth = False
        if auth and datetime.fromtimestamp(exp_date) < datetime.utcnow():
            auth = False
        if auth and iss != "timber":
            auth = False
        if auth and not check_if_user_exists(user):
            auth = False
        if auth:
            return func(*args, **kwargs)
        else:
            return {"error": "Unauthorized"}, 401    
    return inner

@app.before_request
def retrieve_token():
    auth_token = request.headers.get('Authorization','').replace('Bearer ','')
    try:
        g.authorization = decode(auth_token, JWT_SECRET, algorithms='HS256')
    except Exception:
        g.authorization = {}

@app.after_request
def add_headers(response):
    header = response.headers
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
    return response

@app.route("/register", methods=["POST"])
def register():

    data, correct = validate_registration_data(request.json)
    if not correct:
        return {"msg" : "incorrect"}, 400

    email = data["email"].lower()
    if check_if_user_exists(email):
        return { "msg" : "taken"}, 400

    try:
        hashed_pw = hashpw(data["password"].encode(), gensalt())
        db.hset("user:" + email, mapping={"name" : data["name"],
                                                  "password" : hashed_pw,
                                                  "email" : data["email"]})
    except Exception:
        return {"msg" : "dberror"}, 500
    finally:
        return {"msg" : "success"}, 200   

@app.route("/login", methods=["POST"])
def login():

    data, correct = validate_login_data(request.json)
    if not correct:
        return {"msg" : "incorrect"}, 400

    email = data["email"].lower()

    print(check_if_user_exists(email))
    if not check_if_user_exists(email):
        return {"msg" : "incorrect"}, 400

    pw_check = checkPassword(email, data["password"])

    if pw_check is None:
        return {"msg" : "dberror"}, 500

    if not pw_check:
        return {"msg" : "incorrect"}, 400
    
    else:
        token = generate_token(email)
        if token:
            return {"msg" : "success",
                    "token" : token.decode()}, 200
        else:
            return {"msg" : "dberror"}, 500
  
@app.route("/survey", methods=["GET"])
@auth_needed
def surveyGet():
    return QUESTIONS, 200

@app.route("/survey", methods=["POST"])
@auth_needed
def surveyPost():
    data, correct = validate_survey_data(request.json)
    if not correct:
        return {"msg" : "incorrect"}, 400

    data_for_survey = {k:data[str(k)] for k in range(75)}
    data_for_user = {"drag_and_drop":data['75'], "love_type":data['76'], "gender":GENDERS_SYMBOLS[int(data['77'])], "interests":INTERESTS_SYMBOLS[int(data['78'])]}
    try:
        db.hset("survey:" + g.authorization.get('usr'), mapping = data_for_survey)
        db.hset("user:" + g.authorization.get('usr'), mapping = data_for_user)
    except Exception:
        return {"msg":"dberror"}, 500
    req_data = {"user" : {"email" : g.authorization.get('usr')}}
    print("WYSYŁAM POSTA DO ML: ")
    print(req_data)
    res = post(ML_URL, data=dumps(req_data), headers={"Content-Type":"application/json"})
    print(res)
    return {"msg":"success"}, 200

@app.route("/matches", methods=["GET"])
@auth_needed
def matches():
    email = g.authorization.get('usr')
    gender = get_gender(email)
    interest = get_interest(email)
    result = {}

    try:
        result = db.zrange(f"partners:{email}", start = 0, end = -1, desc=True, withscores=True)
    except Exception:
        pass

    to_return = {}
    for i, person in enumerate(result): 
        person_email = person[0].decode()      
        person_gender = get_gender(person_email)
        person_interest = get_interest(person_email)
        if person_gender in interest and gender in person_interest:
            to_return[i] = {"name": get_user_name(person_email), "email": person_email,
                            "score": person[1], "gender": person_gender, "drag_and_drop": get_drag_and_drop(person_email),
                            "love_type": get_love_type(person_email)}
    print(to_return)
    return to_return, 200

@app.route("/refresh", methods=["POST"])
@auth_needed
def refresh():
    token = generate_token(g.authorization.get('usr'))
    if token:
        return {"msg": "success",
                "token": token.decode()}, 200
    else:
        return {"msg": "dberror"}, 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)