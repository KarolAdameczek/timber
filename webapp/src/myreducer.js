export function myreducer(state, action) {
  if (action.type === "ERROR") {
    return { ...state, error: action.message, message: "" };
  } else if (action.type === "MESSAGE") {
    return { ...state, error: "", message: action.message };
  } else if (action.type === "LOADING") {
    return { ...state, spinner: true };
  } else if (action.type === "LOADING_COMPLETED") {
    return { ...state, spinner: false };
  } else {
    state = { ...state, error: "", message: "" };
    switch (action.type) {
      case "SET_LOGGED_IN":
        var tokenData;
        try {
          tokenData = JSON.parse(atob(action.value.token.split(".")[1]));
        } catch (e) {
          return {
            ...state,
            error: "Błąd logowania, spróbuj ponownie później"
          };
        }

        return {
          ...state,
          isLoggedIn: true,
          surveyCompleted: tokenData.survey,
          token: action.value.token,
          userEmail: tokenData.usr,
          userName: tokenData.name,
          expiresOn: tokenData.exp
        };

      case "SET_LOGGED_OUT":
        return {
          ...state,
          isLoggedIn: false,
          surveyCompleted: false,
          surveyQuestions: {},
          matches: {},
          userEmail: "",
          userName: "",
          token: "",
          expiresOn: "",
          error: ""
        };

      case "SET_SURVEY_QUESTIONS":
        return {
          ...state,
          surveyQuestions: action.value
        };

      case "SET_SURVEY_COMPLETED":
        return {
          ...state,
          surveyCompleted: action.value,
          surveyQuestions: {}
        };

      case "SET_MATCHES":
        return {
          ...state,
          matches: action.value
        };
      default:
        return state;
    }
  }
}
