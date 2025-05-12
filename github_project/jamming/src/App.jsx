
import './App.css'

import Playlist from './Playlist.jsx';
import SearchBar from './SearchBar.jsx';
import SearchResults from './SearchResults.jsx';
import Tracklist from './Tracklist.jsx';
import Track from './Track.jsx';


export default function App() {

  return (
    <>
      <div className="header">
      <h1>Jamming</h1>
      <h2>Spotify Playlist Creator</h2>
      <h3>Search for your favorite songs and create a playlist</h3>
      <SearchBar />
      </div>

      <main>
        <Playlist />
        <SearchResults />
        <Tracklist />
        <Track />
      </main>
    </>
  )
}
