import React, { Component } from "react";

export class SurveyQuestionRadio extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selected: undefined
    };
  }

  render() {
    const radioButtons = [];
    for (let i = 1; i < 6; i++) {
      radioButtons.push(
        <li key={i} className="radio-li">
          <div className="form-check form-check-inline">
            <input
              value={i}
              className="form-check-input"
              type="radio"
              name="questionRadio"
              id="{i}"
              onChange={(e) => this.setState({ selected: i })}
            />
            <label className="form-check-label" htmlFor="question{i}">
              {i}
            </label>
          </div>
        </li>
      );
    }

    const onSubmit = (e) => {
      e.preventDefault();
      if (this.state.selected) this.props.onSubmit(this.state.selected);
    };

    return (
      <div>
        <h1>{this.props.question}</h1>
        <form className="survey-form" onSubmit={onSubmit}>
          <ul>{radioButtons}</ul>
          <br />
          <input type="submit" value="Dalej"></input>
        </form>
        <ul className="description-ul">
          <li>1 – całkowicie nietrafnie mnie opisuje</li>
          <li>2 – raczej nietrafnie mnie opisuje</li>
          <li>3 – trochę trafnie, a trochę nietrafnie mnie opisuje</li>
          <li>4 – raczej trafnie mnie opisuje</li>
          <li>5 – całkowicie trafnie mnie opisuje</li>
        </ul>
      </div>
    );
  }
}
