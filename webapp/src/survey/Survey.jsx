import React, { Component } from "react";
import { SurveyQuestionSort } from "./SurveyQuestionSort";
import { SurveyQuestionRadio } from "./SurveyQuestionRadio";
import { SurveyQuestionPick } from "./SurveyQuestionPick";
import { Progress } from "reactstrap";
import { Redirect } from "react-router-dom";

import { setSurveyCompleted } from "../myactions";

export class Survey extends Component {
  constructor(props) {
    super(props);
    this.state = {
      questionQuantity: Object.keys(this.props.questions).length,
      currentQuestion: 0,
      answers: {}
    };
  }

  render() {
    if (this.state.questionQuantity === this.state.currentQuestion) {
      this.props.dispatch(
        setSurveyCompleted(this.state.answers, this.props.token)
      );
      return <Redirect to={this.props.redirectOnCompletedTo} />;
    }

    const currentQuestion = this.props.questions[this.state.currentQuestion];
    var questionComponent;

    const handleQuestionAnswer = (answer) => {
      const a = this.state.currentQuestion + 1;
      const answers = this.state.answers;
      answers[this.state.currentQuestion] = answer;
      this.setState({
        currentQuestion: a,
        answers: answers
      });
    };

    switch (currentQuestion.type) {
      case 0:
        questionComponent = (
          <SurveyQuestionRadio
            question={currentQuestion.text}
            onSubmit={handleQuestionAnswer}
          />
        );
        break;

      case 1:
        questionComponent = (
          <SurveyQuestionPick
            question={currentQuestion.text}
            items={currentQuestion.items}
            onSubmit={handleQuestionAnswer}
            link={currentQuestion.link}
          />
        );
        break;

      case 2:
        questionComponent = (
          <SurveyQuestionSort
            question={currentQuestion.text}
            items={currentQuestion.items}
            onSubmit={handleQuestionAnswer}
          />
        );
        break;

      default:
        break;
    }

    return (
      <div>
        <div>
          <Progress
            className="mx-3 mt-3 mb-2"
            striped
            value={this.state.currentQuestion}
            min={0}
            max={this.state.questionQuantity}
          >
            {this.state.currentQuestion + " / " + this.state.questionQuantity}
          </Progress>
        </div>
        {questionComponent}
      </div>
    );
  }
}
