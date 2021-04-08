population = [1, 2, 3, 4, 5]
weights = {
            'P':[0.05, 0.15, 0.2, 0.4, 0.2], 
            'N':[0.2, 0.4, 0.2, 0.15, 0.05],
          }
questions = {
             1:'I', 2:'E', 3:'S', 4:'F', 5:'J',
             6:'J', 7:'E', 8:'S', 9:'J', 10:'F',
             11:'F', 12:'I', 13:'F', 14:'F', 15:'J',
             16:'I', 17:'P', 18:'P', 19:'J', 20:'F',
             21:'F', 22:'P', 23:'T', 24:'J', 25:'J',
             26:'T', 27:'E', 28:'F', 29:'S', 30:'N',
             31:'F', 32:'I', 33:'N', 34:'I', 35:'P',
             36:'J', 37:'I', 38:'N', 39:'J', 40:'P',
             41:'I', 42:'E', 43:'F', 44:'F', 45:'E',
             46:'I', 47:'N', 48:'J', 49:'T', 50:'T',
             51:'P', 52:'S', 53:'T', 54:'J', 55:'P',
             56:'S', 57:'F', 58:'J', 59:'F', 60:'P',
             61:'P', 62:'N', 63:'S', 64:'E', 65:'S',
             66:'F', 67:'E', 68:'S', 69:'J', 70:'J',
             71:'E', 72:'I', 73:'S', 74:'T', 75:'J',
             76:'E', 77:'I', 78:'P', 79:'J', 80:'I',
             81:'F', 82:'I', 83:'S', 84:'E', 85:'P',
             86:'E', 87:'S', 88:'J', 89:'F', 90:'P',
             91:'S', 92:'E', 93:'N', 94:'P', 95:'F',
             96:'E', 97:'E', 98:'I'
            }
love_types = {
              1:'Eros',
              2:'Ludus',
              3:'Storge',
              4:'Pragma',
              5:'Mania',
              6:'Agape'
             }

from random import randint, choices, choice

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
    return personality, personality_string

def get_answer(key, personality_str):
    key = questions[key]
    if key in personality_str:
        return choices(population, weights['P'])[0]
    else:
        return choices(population, weights['N'])[0]

def get_love_type():
    pop = [1 , 2, 3, 4, 5, 6]
    result = choice(pop)
    return result, love_types[result]