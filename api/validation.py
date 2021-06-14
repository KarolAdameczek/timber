from re import fullmatch, search

email_pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
password_pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$"
name_pattern = r"^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćńółęąś]+$"
d_n_d_pattern = r"^([0-4]{1},{1}){4}[0-4]{1}$"

def validate_login_data(data):
    correct = True
    try:
        if data is None:
            correct = False

        if correct and (not "email" in data or not "password" in data):
            correct = False

        if correct:
            email = data["email"]
            password = data["password"]

        if correct and email is None:
            correct = False
        if correct and fullmatch(email_pattern, email) is None:
            correct = False

        if correct and password is None:
            correct = False
        if correct and fullmatch(password_pattern, password) is None:
            correct = False
    except:
        correct = False
    print(f"Login validation {correct}")
    return data, correct

def validate_registration_data(data):
    correct = True
    try:
        if data is None:
            correct = False

        if correct and (not "email" in data or not "password" in data or not "name" in data):
            correct = False

        if correct:
            name = data["name"]
            email = data["email"]
            password = data["password"]

        if correct and email is None:
            correct = False
        if correct and fullmatch(email_pattern, email) is None:
            correct = False

        if correct and password is None:
            correct = False
        if correct and fullmatch(password_pattern, password) is None:
            correct = False

        if correct and name is None:
            correct = False
        if correct and fullmatch(name_pattern, name) is None:
            correct = False
    except Exception:
        correct = False
    print(f"Registration validation {correct}")
    return data, correct

def validate_survey_data(data):
    correct = True
    print(data)
    try:
        if data is None:
            correct = False
        if correct and len(data) != 79:
            correct = False
        if correct and not all(k.isdigit() for k in data.keys()):
            correct = False
        if correct and any(k is None for k in data.values()):
            correct = False
        if correct:
            for id in range(75):
                if not isinstance(data[str(id)], int):
                    correct = False
                    break
                elif data[str(id)] < 1 or data[str(id)] > 5:
                    correct = False
                    break
        if correct:                
            d_n_d = data['75']
            l_t = data['76']
            g = data['77']
            i = data['78']
        
        if correct and fullmatch(d_n_d_pattern, d_n_d) is None:
            correct = False
        if correct and not isinstance(l_t, int) and (l_t < 0 or l_t > 5):
            correct = False 
        if correct and not isinstance(g, int) and (g < 0 or g > 2):
            correct = False 
        if correct and not isinstance(i, int) and (i < 0 or i > 3):
            correct = False 
    except Exception:
        correct = False
    print(f"Survey validation {correct}")
    return data, correct