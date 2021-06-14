import { createStore, applyMiddleware } from "redux";
import { myreducer } from "./myreducer";
import thunk from "redux-thunk";

const initialState = {
  isLoggedIn: false,
  surveyCompleted: false,
  surveyQuestions: {},
  matches: {},
  userEmail: "",
  userName: "",
  token: "",
  expiresOn: "",
  error: "",
  message: "",
  spinner: false
};

const store = createStore(myreducer, initialState, applyMiddleware(thunk));

export default store;

/*
{ id: 0, type: 0, text: "Pytanie radio" },
    {
      id: 1,
      type: 1,
      text: "Pytanie pick",
      items: ["Item 1", "Item 2", "Item 3"]
    },
    {
      id: 2,
      type: 2,
      text: "Pytanie sort",
      items: ["Item 1", "Item 2", "Item 3", "Item 1", "Item 2", "Item 3"]
    }

    */
