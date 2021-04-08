from gens import *
from sys import argv
from os import mkdir, path
from random import shuffle
import json

def main(how_many):
    for i in range(1, how_many + 1):
        test_result = {}
        test_result['personality_type'], test_result['personality_string'] = get_random_personality()
        answers = {}
        for k in questions:
            answers[k] = get_answer(k, test_result['personality_string'])
        test_result['survey_answers'] = answers
        to_shuffle = [1, 2, 3, 4, 5]
        shuffle(to_shuffle)
        test_result['sorting_answer'] = int(''.join([str(i) for i in to_shuffle]))
        test_result['love_type'], test_result['love_type_string'] = get_love_type()
        with open(f'output/answers{i}.json', 'w') as f:
            json.dump(test_result, f, ensure_ascii=False, indent=4)

if __name__ == '__main__':
    if not argv[1]:
        print("Nie podano liczby odpoweidzi do wygenerowania")
        exit()
    try:
        no_replies = int(argv[1])
    except ValueError:
        print("Podaj liczbę, a nie jakieś coś na kiju")
        exit()
    if not path.isdir('output'):
        try:
            mkdir('output')
        except OSError:
            print ("Nie udało się utworzyć katalogu output")
            exit()
    main(no_replies)
