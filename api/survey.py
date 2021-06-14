PRIORITIES = ["Czas spędzony razem", "Dawanie i przyjmowanie prezentów", "Dotyk", "Drobne przysługi", "Słowa aprobaty"]
LOVE_TYPES = ["Storge", "Eros", "Ludus", "Mania", "Pragma", "Agape"]
GENDERS = ["Mężczyzna", "Kobieta", "Niebinarna"]
INTERESTS = ["Mężczyźni", "Kobiety", "Niebinarne", "Wszystkie"]
GENDERS_SYMBOLS = ['m', 'f', 'n']
INTERESTS_SYMBOLS = ['m', 'f', 'n', 'mfn']

QUESTIONS = {
    0 : {"id": "A1", "type": 0, "text": "Wiem jak pocieszyć drugą osobę.", "items": [1, 2, 3, 4, 5]},
    1 : {"id": "A8", "type": 0, "text": "Nie lubię być zaplątany w problemy innych osób.", "items": [1, 2, 3, 4, 5]},
    2 : {"id": "B10", "type": 0, "text": "Często czuję zmieszanie.", "items": [1, 2, 3, 4, 5]},
    3 : {"id": "B11", "type": 0, "text": "Wiem, że nie jestem nikim specjalnym.", "items": [1, 2, 3, 4, 5]},
    4 : {"id": "B13", "type": 0, "text": "Pomijam trudne wyrazy podczas czytania.", "items": [1, 2, 3, 4, 5]},
    5 : {"id": "B9", "type": 0, "text": "Uważam, że jestem zwyczajnym człowiekiem.", "items": [1, 2, 3, 4, 5]},
    6 : {"id": "C1", "type": 0, "text": "Rzadko popadam w melancholię.", "items": [1, 2, 3, 4, 5]},
    7 : {"id": "C2", "type": 0, "text": "Czuję się komfortowo we własnym towarzystwie.", "items": [1, 2, 3, 4, 5]},
    8 : {"id": "C4", "type": 0, "text": "Zazwyczaj jestem zrelaksowany(a).", "items": [1, 2, 3, 4, 5]},
    9 : {"id": "C5", "type": 0, "text": "Trudno mnie zdenerwować", "items": [1, 2, 3, 4, 5]},
    10 : {"id": "C9", "type": 0, "text": "Jestem zdesperowany(a).", "items": [1, 2, 3, 4, 5]},
    11 : {"id": "D10", "type": 0, "text": "Pozwalam sobą pomiatać", "items": [1, 2, 3, 4, 5]},
    12 : {"id": "E10", "type": 0, "text": "Nie lubię głośnej muzyki", "items": [1, 2, 3, 4, 5]},
    13 : {"id": "E4", "type": 0, "text": "Lubię być w centrum głośnego tłumu.", "items": [1, 2, 3, 4, 5]},
    14 : {"id": "E6", "type": 0, "text": "Podejmuję szalone i nieprzemyślane decyzje.", "items": [1, 2, 3, 4, 5]},
    15 : {"id": "E8", "type": 0, "text": "Nie lubię tłumów.", "items": [1, 2, 3, 4, 5]},
    16 : {"id": "F1", "type": 0, "text": "Uważam, że prawo powinno być skutecznie egzekwowane.", "items": [1, 2, 3, 4, 5]},
    17 : {"id": "F3", "type": 0, "text": "Staram się orzestrzegać zasad.", "items": [1, 2, 3, 4, 5]},
    18 : {"id": "F4", "type": 0, "text": "Respektuję autorytety.", "items": [1, 2, 3, 4, 5]},
    19 : {"id": "F5", "type": 0, "text": "Zawsze wstaję gdy śpiewany jest hymn państwowy", "items": [1, 2, 3, 4, 5]},
    20 : {"id": "F7", "type": 0, "text": "Łamię zasady.", "items": [1, 2, 3, 4, 5]},
    21 : {"id": "F8", "type": 0, "text": "Często przeklinam.", "items": [1, 2, 3, 4, 5]},
    22 : {"id": "G3", "type": 0, "text": "Nie przeszkadza mi bycie w centrum uwagi.", "items": [1, 2, 3, 4, 5]},
    23 : {"id": "G7", "type": 0, "text": "Często czuję się niekomfortowo w otoczeniu innych osób.", "items": [1, 2, 3, 4, 5]},
    24 : {"id": "G8", "type": 0, "text": "Nie mam dużo do powiedzenia.", "items": [1, 2, 3, 4, 5]},
    25 : {"id": "G9", "type": 0, "text": "Jestem nieśmiały(a) w stosunku do obcych osób.", "items": [1, 2, 3, 4, 5]},
    26 : {"id": "H10", "type": 0, "text": "Nie lubię fantastyki.", "items": [1, 2, 3, 4, 5]},
    27 : {"id": "H3", "type": 0, "text": "Dużo czytam.", "items": [1, 2, 3, 4, 5]},
    28 : {"id": "H4", "type": 0, "text": "Nie lubię filmów akcji.", "items": [1, 2, 3, 4, 5]},
    29 : {"id": "H5", "type": 0, "text": "Często płaczę na filmach.", "items": [1, 2, 3, 4, 5]},
    30 : {"id": "H6", "type": 0, "text": "Kocham kwiaty.", "items": [1, 2, 3, 4, 5]},
    31 : {"id": "H7", "type": 0, "text": "Nie lubię oglądać występów tanecznych.", "items": [1, 2, 3, 4, 5]},
    32 : {"id": "H8", "type": 0, "text": "Nie lubię poezji.", "items": [1, 2, 3, 4, 5]},
    33 : {"id": "I1", "type": 0, "text": "Trudno jest mi przebaczać innym.", "items": [1, 2, 3, 4, 5]},
    34 : {"id": "I2", "type": 0, "text": "Doszukuję się ukrytych zamiarów u innych.", "items": [1, 2, 3, 4, 5]},
    35 : {"id": "I4", "type": 0, "text": "Nie ufam ludziom.", "items": [1, 2, 3, 4, 5]},
    36 : {"id": "I5", "type": 0, "text": "Uważam, że ludzie rzadko mówią całą prawdę.", "items": [1, 2, 3, 4, 5]},
    37 : {"id": "J1", "type": 0, "text": "Lubię rzeczy, które inni uważają za dziwne.", "items": [1, 2, 3, 4, 5]},
    38 : {"id": "J10", "type": 0, "text": "Rzadko zdarza mi się zamyśleć.", "items": [1, 2, 3, 4, 5]},
    39 : {"id": "J2", "type": 0, "text": "Lubię zatracić się w przemyśleniach.", "items": [1, 2, 3, 4, 5]},
    40 : {"id": "J3", "type": 0, "text": "Lubię puścić wodzę fantazji.", "items": [1, 2, 3, 4, 5]},
    41 : {"id": "K1", "type": 0, "text": "Ujawniam mało informacji o sobie.", "items": [1, 2, 3, 4, 5]},
    42 : {"id": "K10", "type": 0, "text": "Lubię opowiadać o sobie.", "items": [1, 2, 3, 4, 5]},
    43 : {"id": "K2", "type": 0, "text": "Trudno jest mnie poznać.", "items": [1, 2, 3, 4, 5]},
    44 : {"id": "K4", "type": 0, "text": "Często zachowuję uczucia dla siebie.", "items": [1, 2, 3, 4, 5]},
    45 : {"id": "K8", "type": 0, "text": "Dzielę się swoimi prywatnymi przemyśleniami.", "items": [1, 2, 3, 4, 5]},
    46 : {"id": "K9", "type": 0, "text": "Okazuję moje uczucia.", "items": [1, 2, 3, 4, 5]},
    47 : {"id": "L1", "type": 0, "text": "Boję sie, że zrobię coś złego.", "items": [1, 2, 3, 4, 5]},
    48 : {"id": "L10", "type": 0, "text": "Nie pozwalam innym się zniechęcić.", "items": [1, 2, 3, 4, 5]},
    49 : {"id": "L2", "type": 0, "text": "Łatwo sprawić, żebym czuł(a) się zagrożony(a)", "items": [1, 2, 3, 4, 5]},
    50 : {"id": "L4", "type": 0, "text": "Przejmuję się wszystkim.", "items": [1, 2, 3, 4, 5]},
    51 : {"id": "L5", "type": 0, "text": "Spędzam czas kontemplując błędy z przeszłości.", "items": [1, 2, 3, 4, 5]},
    52 : {"id": "L6", "type": 0, "text": "Czuję się winny(a) kiedy komuś odmawiam.", "items": [1, 2, 3, 4, 5]},
    53 : {"id": "L7", "type": 0, "text": "Niepowodzenia mnie przytłaczają.", "items": [1, 2, 3, 4, 5]},
    54 : {"id": "L8", "type": 0, "text": "Nie przejmuję się rzeczami, które już się wydarzyły.", "items": [1, 2, 3, 4, 5]},
    55 : {"id": "L9", "type": 0, "text": "Rzadko jestem czymś zaniepokojony(a).", "items": [1, 2, 3, 4, 5]},
    56 : {"id": "M1", "type": 0, "text": "Wierzę w to, że sztuka jest ważna.", "items": [1, 2, 3, 4, 5]},
    57 : {"id": "M5", "type": 0, "text": "Wolę różnorodność niż rutynę.", "items": [1, 2, 3, 4, 5]},
    58 : {"id": "M7", "type": 0, "text": "Rzadko doszukuję się głębszego znaczenia w rzeczach.", "items": [1, 2, 3, 4, 5]},
    59 : {"id": "N1", "type": 0, "text": "Chcę być sam(a).", "items": [1, 2, 3, 4, 5]},
    60 : {"id": "N10", "type": 0, "text": "Nie jestem sobą bez towarzystwa innych.", "items": [1, 2, 3, 4, 5]},
    61 : {"id": "N2", "type": 0, "text": "Wolę robić rzeczy samodzielnie.", "items": [1, 2, 3, 4, 5]},
    62 : {"id": "N5", "type": 0, "text": "Nie przeszkadza mi jedzenie w pojedynkę.", "items": [1, 2, 3, 4, 5]},
    63 : {"id": "N6", "type": 0, "text": "Lubię ciszę.", "items": [1, 2, 3, 4, 5]},
    64 : {"id": "N9", "type": 0, "text": "Lubię pracę w grupie.", "items": [1, 2, 3, 4, 5]},
    65 : {"id": "O10", "type": 0, "text": "Odkładam nieprzyjemne zadania na później.", "items": [1, 2, 3, 4, 5]},
    66 : {"id": "O2", "type": 0, "text": "Obowiązki domowe wykonuję od razu.", "items": [1, 2, 3, 4, 5]},
    67 : {"id": "O4", "type": 0, "text": "Nie kończę pracy dopóki nie osiągnę perfekcji.", "items": [1, 2, 3, 4, 5]},
    68 : {"id": "O6", "type": 0, "text": "Nie przeszkadzają mi niechlujni ludzie.", "items": [1, 2, 3, 4, 5]},
    69 : {"id": "O7", "type": 0, "text": "Nie przeszkadza mi nieporządek.", "items": [1, 2, 3, 4, 5]},
    70 : {"id": "O8", "type": 0, "text": "Często mam bałagan w pokoju.", "items": [1, 2, 3, 4, 5]},
    71 : {"id": "P2", "type": 0, "text": "Łatwo się denerwuję.", "items": [1, 2, 3, 4, 5]},
    72 : {"id": "P4", "type": 0, "text": "Denerwują mnie błędy innych.", "items": [1, 2, 3, 4, 5]},
    73 : {"id": "P6", "type": 0, "text": "Nie znoszę, kiedy ktoś się ze mną nie zgadza.", "items": [1, 2, 3, 4, 5]},
    74 : {"id": "P7", "type": 0, "text": "Oceniam ludzi po wyglądzie.", "items": [1, 2, 3, 4, 5]},
    75 : {"id": "DragAndDrop", "type": 2, "text" : "Ustaw w kolejności, w jakiej te rzeczy są dla Ciebie ważne w związku", "items": PRIORITIES},
    76 : {"id": "LoveType", "type": 1, "text" : "Określ swój typ miłości", "link" : "https://pl.wikipedia.org/wiki/Mi%C5%82o%C5%9B%C4%87#Teoretyczny_model_mi%C5%82o%C5%9Bci_Johna_Lee", "items" : LOVE_TYPES},
    77 : {"id": "gender", "type" : 1, "text" : "Określ swoją płeć", "items" : GENDERS},
    78 : {"id": "interests", "type" : 1, "text" : "Określ, jakie osoby Cię interesują", "items" : INTERESTS}
}