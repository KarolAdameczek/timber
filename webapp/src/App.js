import { Switch, Route, Link, Redirect, useLocation } from "react-router-dom";
import "./styles.css";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";

import React from "react";
import logo from "./logo.png"
import { Spinner } from "reactstrap";

import { Survey } from "./survey/Survey";
import { PersonPicker } from "./PersonPicker";
import { RegisterView } from "./Register";
import { LoginView } from "./Login";

import { connect } from "react-redux";

import {
  clearMessagesAndErrors,
  getSurveyQuestions,
  logoutUser
} from "./myactions";

function App(props) {
  const location = useLocation();
  const dispatch = props.dispatch;

  React.useEffect(() => {
    dispatch(clearMessagesAndErrors());
  }, [location, dispatch]);

  if (
    props.isLoggedIn &&
    !props.surveyCompleted &&
    Object.keys(props.surveyQuestions).length === 0
  ) {
    dispatch(getSurveyQuestions(props.token));
  }

  return (
    <div className="App">
      <article>
        <nav className="nav">
          <Link to="/">
            <img src={logo} alt="" className="logo" />
          </Link>
          <div className="links-container">
            <ul className="links">
              {(!props.isLoggedIn ||
                (props.isLoggedIn && props.surveyCompleted)) && (
                <li>
                  <Link to="/">Strona główna</Link>
                </li>
              )}
              {!props.isLoggedIn && (
                <li>
                  <Link to="/login">Logowanie</Link>
                </li>
              )}
              {!props.isLoggedIn && (
                <li>
                  <Link to="/register">Rejestracja</Link>
                </li>
              )}
              {props.isLoggedIn && props.surveyCompleted && (
                <li>
                  <Link to="/matches">Potencjalni partnerzy</Link>
                </li>
              )}
              {props.isLoggedIn && (
                <li>
                  <Link
                    to="/"
                    onClick={(e) => {
                      e.preventDefault();
                      props.dispatch(logoutUser());
                    }}
                  >
                    Wyloguj
                  </Link>
                </li>
              )}
            </ul>
          </div>
        </nav>
        {props.message !== "" && (
          <div className="message-div">{props.message}</div>
        )}
        {props.error !== "" && <div className="error-div">{props.error}</div>}
        {props.spinner && <Spinner />}
        <Switch>
          {!props.isLoggedIn && (
            <Route exact path="/login">
              <LoginView dispatch={props.dispatch} />
            </Route>
          )}
          {!props.isLoggedIn && (
            <Route exact path="/register">
              <RegisterView dispatch={props.dispatch} error={props.error} />
            </Route>
          )}
          {props.isLoggedIn && props.surveyCompleted && (
            <Route exact path="/matches">
              <PersonPicker
                dispatch={props.dispatch}
                token={props.token}
                matches={props.matches}
              />
            </Route>
          )}
          {props.isLoggedIn &&
            !props.surveyCompleted &&
            Object.keys(props.surveyQuestions).length && (
              <Route exact path="/survey">
                <Survey
                  redirectOnCompletedTo="/"
                  dispatch={props.dispatch}
                  questions={props.surveyQuestions}
                  token={props.token}
                />
              </Route>
            )}
          <Route exact path="/">
            <MainView />
          </Route>
          <Route
            render={() => {
              if (props.isLoggedIn && !props.surveyCompleted)
                return <Redirect to={{ pathname: "/survey" }} />;
              else return <Redirect to={{ pathname: "/" }} />;
            }}
          />
        </Switch>
      </article>
      <footer className="footer">
        <a href="https://github.com/KarolAdameczek/timber">GitHub projektu</a>
      </footer>
    </div>
  );
}

function MainView(props) {
  return (
    <div>
      <p className="main-page-header"> SZUKASZ PRAWDZIWEJ MIŁOŚCI? </p>
      <p className="main-page-header"> BRAKUJE CI BRATNIEJ DUSZY? </p>
      <p className="main-page-header"> LOS CZĘSTO GRA Z TOBĄ W POKERA, RAZ CI DAJE RAZ ZABIERA? </p>
      <p className="main-page-content"> To właściwe miejsce, Timber jest stworzony właśnie dla Ciebie!
      <br/>Korzystamy z najnowszych osiągnięc techniki, aby zapewnić naszym użytkownikom najlepsze dopasowanie potencjalnych partnerów.
      <br/>Mamy tysiące zadowolonych użytkowników, wystarczy spojrzeć na ich opinie:</p>
      
      <div className="comment-container">
      "Dzięki Timber znalazłam już trzech mężów. Właśnie szukam tu następnego!"
      <br/> <div className="comment-name"> ~Grażynka </div>
      </div>

      <div className="comment-container">
      "Los nie chciał dać mi nowej miłości, dzięki Timber znalazłem ją w kilka chwil."
      <br/> <div className="comment-name"> ~Zenon </div>
      </div>

      <div className="comment-container">
      "Sprawdzałem wiele serwisów tego typu, jednak to dopiero Timber sprawił, że konar zapłonął."
      <br/> <div className="comment-name"> ~Pablo </div>
      </div>

    </div>
  );
}

function mapStateToProps(state) {
  return state;
}

export default App = connect(mapStateToProps)(App);
