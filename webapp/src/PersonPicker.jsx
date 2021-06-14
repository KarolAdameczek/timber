import React, { Component } from "react";
import { getMatches } from "./myactions";
import { Collapse } from "reactstrap";

export class PersonPicker extends Component {
  constructor(props) {
    super(props);
    if (Object.keys(this.props.matches).length === 0) {
      this.props.dispatch(getMatches(this.props.token));
    }
  }

  render() {
    return (
      <div>
        <h1>Potencjalni partnerzy</h1>
        <h3>Im wyżej, tym lepsze dopasowanie</h3>
        <div>
          {Object.keys(this.props.matches).map((key, _) => (
            <InfoTab
              name={this.props.matches[key].name}
              email={this.props.matches[key].email}
              key={this.props.matches[key].email}
              priorities={this.props.matches[key].drag_and_drop}
              lovetype={this.props.matches[key].love_type}
              score={this.props.matches[key].score}
            />
          ))}
        </div>
      </div>
    );
  }
}

class InfoTab extends Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false
    };
  }

  render() {
    return (
      <div className="person-picker-container">
        <div
          className="info-tab-container"
          onClick={() => this.setState({ open: !this.state.open })}
        >
          <br />
          <div className="name-div">{this.props.name}</div>
          <Collapse isOpen={this.state.open}>
            <div className="email-div">Email: {this.props.email} </div>
            <div className="email-div">Dopasowanie: {this.props.score}%</div>
            <div className="email-div">Typ miłości: {this.props.lovetype}</div>
            <div className="email-div">
              Dwie najważniejsze rzeczy w związku:
              <br />
              {this.props.priorities}
            </div>
          </Collapse>
        </div>
      </div>
    );
  }
}
