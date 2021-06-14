import React, { Component } from "react";

export class SurveyQuestionPick extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selected: undefined
    };
  }

  render() {
    const radioButtons = [];

    const onSubmit = (e) => {
      e.preventDefault();
      if (this.state.selected !== undefined) this.props.onSubmit(this.state.selected);
    };

    for (let i = 0; i < this.props.items.length; i++) {
      radioButtons.push(
        <li key={i} className="">
          <div className="form-check">
            <input
              className="form-check-input"
              type="radio"
              name="questionRadio"
              id="question{i}"
              onChange={(e) => this.setState({ selected: i })}
            />
            <label className="form-check-label" htmlFor="question{i}">
              {this.props.items[i]}
            </label>
          </div>
        </li>
      );
    }

    return (
      <div>
        <h2>{this.props.question}</h2>
        <form className="survey-form" onSubmit={onSubmit}>
          <ul>{radioButtons}</ul>
          <br />
          <input type="submit" value="Dalej"></input>
        </form>
        {this.props.link && (
          <a
            href={this.props.link}
            target={"_blank"}
            rel={"noopener noreferrer"}
          >
            Opisy typów miłości
          </a>
        )}
      </div>
    );
  }
}
