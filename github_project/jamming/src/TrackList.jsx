import Track from "./Track.jsx";

const TrackList = (props) => {
  return (
    <div className="TrackList" style={{width: '100%'}}>
      {props.tracks.map((track) => {
        return (
          <Track
            track={track}
            key={track.id}
            onAdd={props.onAdd}
            isRemoval={props.isRemoval}
            onRemove={props.onRemove}
          />
        );
      })}
    </div>
  );
};

export default TrackList;
