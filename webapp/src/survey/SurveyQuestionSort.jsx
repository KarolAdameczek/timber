import React, { Component } from "react";
import { DndProvider } from "react-dnd";
import { HTML5Backend } from "react-dnd-html5-backend";
import { Container } from "../dragndrop/Container.jsx";

export class SurveyQuestionSort extends Component {
  render() {
    const handleChange = (newOrder) => {
      this.setState({
        order: newOrder
      });
    };

    const onSubmit = (e) => {
      e.preventDefault();
      if (this.state.order !== undefined) this.props.onSubmit(this.state.order.toString());
    };

    return (
      <div>
        <h2>Ułóż w kolejności od najważniejszego do najmniej ważnego</h2>
        <form className="survey-form" onSubmit={onSubmit}>
          <DndProvider backend={HTML5Backend}>
            <Container answers={this.props.items} onChange={handleChange} />
          </DndProvider>
          <input type="submit" value="Dalej"></input>
        </form>
      </div>
    );
  }
}
