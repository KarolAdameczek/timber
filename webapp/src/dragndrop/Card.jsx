import { memo, useMemo, useRef } from "react";
import { useDrag, useDrop } from "react-dnd";

const ItemTypes = {
  CARD: "card"
};

const style = {
  border: "1px solid gray",
  borderRadius: "5px",
  padding: "0.5rem 1rem",
  marginBottom: ".5rem",
  backgroundColor: "white",
  cursor: "move",
  width: "100%"
};
export const Card = memo(({ id, text, moveCard }) => {
  const ref = useRef(null);
  const [{ isDragging, handlerId }, connectDrag] = useDrag({
    type: ItemTypes.CARD,
    item: { id },
    collect: (monitor) => {
      const result = {
        handlerId: monitor.getHandlerId(),
        isDragging: monitor.isDragging()
      };
      return result;
    }
  });
  const [, connectDrop] = useDrop({
    accept: ItemTypes.CARD,
    hover({ id: draggedId }) {
      if (draggedId !== id) {
        moveCard(draggedId, id);
      }
    }
  });
  connectDrag(ref);
  connectDrop(ref);
  const opacity = isDragging ? 0 : 1;
  const containerStyle = useMemo(() => ({ ...style, opacity }), [opacity]);
  return (
    <div ref={ref} style={containerStyle} data-handler-id={handlerId}>
      {text}
    </div>
  );
});
