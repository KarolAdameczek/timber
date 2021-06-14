import { Component } from "react";
import { Card } from "./Card";
import update from "immutability-helper";
const style = {
  width: "400px",
  maxWidth: "80vw",
  margin: "auto"
};
function buildCardData(answers) {
  const cardsById = {};
  const cardsByIndex = [];
  for (let i = 0; i < answers.length; i += 1) {
    const card = { id: i, text: answers[i] };
    cardsById[card.id] = card;
    cardsByIndex[i] = card;
  }
  return {
    cardsById,
    cardsByIndex
  };
}

export class Container extends Component {
  constructor(props) {
    super(props);
    this.state = {
      order: Array.from({ length: props.answers.length }, (_, k) => k + 1)
    };
    this.drawFrame = () => {
      const nextState = update(this.state, this.pendingUpdateFn);
      this.setState(nextState);
      this.pendingUpdateFn = undefined;
      this.requestedFrame = undefined;
      this.handleOnChange();
    };
    this.moveCard = (id, afterId) => {
      const { cardsById, cardsByIndex } = this.state;
      const card = cardsById[id];
      const afterCard = cardsById[afterId];
      const cardIndex = cardsByIndex.indexOf(card);
      const afterIndex = cardsByIndex.indexOf(afterCard);
      this.scheduleUpdate({
        cardsByIndex: {
          $splice: [
            [cardIndex, 1],
            [afterIndex, 0, card]
          ]
        }
      });
    };
    this.state = buildCardData(props.answers);
    this.handleOnChange();
  }

  handleOnChange() {
    const newOrder = [];
    this.state.cardsByIndex.forEach((elem) => {
      newOrder.push(elem.id);
    });
    this.props.onChange(newOrder);
  }

  componentWillUnmount() {
    if (this.requestedFrame !== undefined) {
      cancelAnimationFrame(this.requestedFrame);
    }
  }

  render() {
    const { cardsByIndex } = this.state;

    return (
      <>
        <div style={style}>
          {cardsByIndex.map((card) => (
            <Card
              key={card.id}
              id={card.id}
              text={card.text}
              moveCard={this.moveCard}
            />
          ))}
        </div>
      </>
    );
  }
  scheduleUpdate(updateFn) {
    this.pendingUpdateFn = updateFn;
    if (!this.requestedFrame) {
      this.requestedFrame = requestAnimationFrame(this.drawFrame);
    }
  }
}
