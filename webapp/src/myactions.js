const api_url = "https://timber-api.herokuapp.com";
const passwordRe = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$/;
const emailRe = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const nameRe = /^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćńółęąś]+$/;

export function loginUser(email, password) {
  return (dispatch) => {
    if (!email || !password) {
      dispatch({
        type: "ERROR",
        message: "Należy wypełnić wszystkie pola"
      });
      return;
    }
    dispatch(startLoading());
    fetch(api_url + "/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ email: email, password: password })
    })
      .then((response) => response.json())
      .then((json) => {
        if (json.msg === "success") {
          dispatch(setLoggedIn(json));
        } else if (json.msg === "incorrect") {
          dispatch({
            type: "ERROR",
            message: "Niepoprawna nazwa użytkownika lub hasło"
          });
        } else {
          dispatch({
            type: "ERROR",
            message: "Błąd logowania, spróbuj ponownie później"
          });
        }
        dispatch(stopLoading());
      })
      .catch((e) => {
        dispatch(stopLoading());
        dispatch({
          type: "ERROR",
          message: "Błąd logowania, spróbuj ponownie później"
        });
      });
  };
}

export function setLoggedIn(loginData) {
  return {
    type: "SET_LOGGED_IN",
    value: loginData
  };
}

export function logoutUser() {
  return (dispatch) => {
    dispatch({
      type: "SET_LOGGED_OUT"
    });
  };
}

export function registerUser(name, email, email2, password, password2) {
  return (dispatch) => {
    if (!name.match(nameRe)) {
      dispatch({
        type: "ERROR",
        message:
          "Imię musi zaczynać się od wielkiej litery i może składać się tylko z liter"
      });
      return;
    } else if (email !== email2) {
      dispatch({ type: "ERROR", message: "Emaile muszą być takie same" });
      return;
    } else if (password !== password2) {
      dispatch({ type: "ERROR", message: "Hasła muszą być takie same" });
      return;
    } else if (!email.match(emailRe)) {
      dispatch({ type: "ERROR", message: "Wprowadzono niepoprawny email" });
      return;
    } else if (!password.match(passwordRe)) {
      dispatch({
        type: "ERROR",
        message:
          "Hasło powinno zawierać co najmniej 8 znaków, dużą i małą literę oraz cyfrę"
      });
      return;
    } else {
      dispatch(clearMessagesAndErrors());
    }
    dispatch(startLoading());
    fetch(api_url + "/register", {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ email: email, password: password, name: name })
    })
      .then((response) => response.json())
      .then((json) => {
        if (json.msg === "success") {
          dispatch({ type: "SET_LOGGED_OUT" });
          dispatch({ type: "MESSAGE", message: "Zarejestrowano" });
        } else if (json.msg === "taken") {
          dispatch({ type: "ERROR", message: "Email jest już zajęty" });
        } else {
          dispatch({
            type: "ERROR",
            message: "Błąd rejestracji, spróbuj ponownie później"
          });
        }
        dispatch(stopLoading());
      })
      .catch((e) => {
        dispatch(stopLoading());
        dispatch({
          type: "ERROR",
          message: "Błąd rejestracji, spróbuj ponownie później"
        });
      });
  };
}

export function getSurveyQuestions(token) {
  return (dispatch) => {
    dispatch(startLoading());
    fetch(api_url + "/survey", {
      method: "GET",
      headers: {
        Authorization: "Bearer " + token,
        Accept: "application/json"
      }
    })
      .then((response) =>
        response.json().then((data) => ({
          json: data,
          status: response.status
        }))
      )
      .then(({ json, status }) => {
        if (status === 401) {
          dispatch(logoutUser());
          dispatch({
            type: "ERROR",
            message: "Sesja wygasła, zaloguj się ponownie"
          });
        } else if (status === 200) {
          dispatch(setSurveyQuestions(json));
        } else {
          dispatch({
            type: "ERROR",
            message: "Błąd pobierania ankiety, spróbuj ponownie później"
          });
        }
        dispatch(stopLoading());
      })
      .catch((e) => {
        dispatch(stopLoading());
        dispatch({
          type: "ERROR",
          message: "Błąd pobierania ankiety, spróbuj ponownie później"
        });
      });
  };
}

function setSurveyQuestions(questions) {
  return {
    type: "SET_SURVEY_QUESTIONS",
    value: questions
  };
}

export function setSurveyCompleted(answers, token) {
  return (dispatch) => {
    dispatch(startLoading());
    fetch(api_url + "/survey", {
      method: "POST",
      headers: {
        Authorization: "Bearer " + token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(answers)
    })
      .then((response) => response.status)
      .then((status) => {
        if (status === 401) {
          dispatch(logoutUser());
          dispatch({
            type: "ERROR",
            message: "Sesja wygasła, zaloguj się ponownie"
          });
        } else if (status === 200) {
          dispatch({
            type: "SET_SURVEY_COMPLETED",
            value: true
          });
        } else {
          dispatch({
            type: "ERROR",
            message: "Błąd wysyłania ankiety, spróbuj ponownie później"
          });
        }
        dispatch(stopLoading());
      })
      .catch((e) => {
        dispatch(stopLoading());
        dispatch({
          type: "ERROR",
          message: "Błąd wysyłania ankiety, spróbuj ponownie później"
        });
      });
  };
}

export function getMatches(token) {
  return (dispatch) => {
    dispatch(startLoading());
    fetch(api_url + "/matches", {
      method: "GET",
      headers: {
        Authorization: "Bearer " + token
      }
    })
      .then((response) =>
        response.json().then((data) => ({
          json: data,
          status: response.status
        }))
      )
      .then(({ json, status }) => {
        if (status === 401) {
          dispatch(logoutUser());
          dispatch({
            type: "ERROR",
            message: "Sesja wygasła, zaloguj się ponownie"
          });
        } else if (status === 200) {
          dispatch(setMatches(json));
        } else {
          dispatch({
            type: "ERROR",
            message:
              "Błąd pobierania potencjalnych partnerów, spróbuj ponownie później"
          });
        }
        dispatch(stopLoading());
      })
      .catch((e) => {
        dispatch(stopLoading());
        dispatch({
          type: "ERROR",
          message:
            "Błąd pobierania potencjalnych partnerów, spróbuj ponownie później"
        });
      });
  };
}

function setMatches(json) {
  return (dispatch) => dispatch({ type: "SET_MATCHES", value: json });
}

export function clearMessagesAndErrors() {
  return (dispatch) => dispatch({ type: "CLEAR" });
}

function startLoading() {
  return (dispatch) => dispatch({ type: "LOADING" });
}

function stopLoading() {
  return (dispatch) => dispatch({ type: "LOADING_COMPLETED" });
}
