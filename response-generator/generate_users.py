from redis import StrictRedis
from names_female import FEMALE_NAMES
from names_male import MALE_NAMES
from email_domains import EMAIL_DOMAINS
from survey import *
from random import choice, choices, shuffle, randint
from sys import argv
from dotenv import load_dotenv
from os import getenv
from requests import post
from json import dumps
from bcrypt import hashpw, gensalt

load_dotenv()
REDIS_HOST = getenv('REDIS_URL')
REDIS_PASS = getenv('REDIS_PASS')
REDIS_PORT = getenv('REDIS_PORT')
ML_URL = getenv('ML_URL')
DEFAULT_PASSWORD = getenv('DEF_PASSWORD').encode()

def generate_user(id):

    gender = choices(GENDERS_SYMBOLS, [0.45, 0.45, 0.1])[0]
    interest = ""

    if gender == "m":
        interest = choices(INTERESTS_SYMBOLS, [0.06, 0.85, 0.02, 0.07])[0]
    if gender == "f":
        interest = choices(INTERESTS_SYMBOLS, [0.85, 0.06, 0.02, 0.07])[0]    
    
    if gender == "n":
        name_gender = choice(["m", "f"])
        interest = choice(INTERESTS_SYMBOLS)
    else:
        name_gender = gender
    
    name = ""
    if name_gender == "m":
        name = choice(MALE_NAMES)
    elif name_gender == "f":
        name = choice(FEMALE_NAMES)
    
    email = name.lower() + str(id) + choice(EMAIL_DOMAINS)
    hashed = hashpw(DEFAULT_PASSWORD, gensalt())

    drag_and_drop = ['0', '1', '2', '3', '4']
    shuffle(drag_and_drop)
    drag_and_drop = ",".join(drag_and_drop)

    love_type = str(choice(range(1,7)))

    survey, personality = generate_survey_responses()

    userinfo = {"name" : name,
                "gender" : gender,
                "interest" : interest,
                "email" : email,
                "password" : hashed,
                "drag_and_drop" : drag_and_drop,
                "love_type" : love_type,
                "personality" : personality}

    print(userinfo)
    print(survey)

    return email, userinfo, survey

def generate_survey_responses():
    personality = get_random_personality()
    resp = dict()
    for id in range(75):
        resp[str(id)] = get_answer(id, personality)
    return resp, personality

def get_random_personality():
    personality = []
    for i in range(0, 4):
        personality.append(randint(0, 1))
    personality_string = []
    personality_string.append('E' if personality[0] == 0 else 'I')
    personality_string.append('S' if personality[1] == 0 else 'N')
    personality_string.append('T' if personality[2] == 0 else 'F')
    personality_string.append('J' if personality[3] == 0 else 'P')
    personality_string = ''.join(personality_string)
    return personality_string

def get_answer(q_id, personality):
    q_personality = QUESTION_PERSONALITY[q_id]
    if q_personality in personality:
        return choices([1, 2, 3, 4, 5], WEIGHTS['P'])[0]
    else:
        return choices([1, 2, 3, 4, 5], WEIGHTS['N'])[0]

if __name__ == "__main__":
    
    if len(argv) < 2:
        print("Proszę podać liczbę użytkowników do wygenerowania jako argument")
        exit()
    if not argv[1].isdigit():
        print("Argument musi być liczbą")
        exit()
    how_many_users = int(argv[1])

    db = StrictRedis(host=REDIS_HOST, port=REDIS_PORT, db=0, password=REDIS_PASS)

    for id in range(how_many_users):
        email, info, survey = generate_user(id)
        db.hset(f"user:{email}", mapping=info)
        db.hset(f"survey:{email}", mapping=survey)
        req_data = {"user" : {"email" : email}}
        resp = post(ML_URL, data=dumps(req_data), headers={"Content-Type":"application/json"})
        print(resp)
