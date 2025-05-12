let accessToken;
const clientId = '6d738abe6b0a404697ffc9ab54a92918';
const redirectUri = 'http://127.0.0.1:5173/';
const scope = 'playlist-modify-public';
const accessUrl = `https://accounts.spotify.com/authorize?client_id=${clientId}&response_type=token&scope=${encodeURIComponent(scope)}&redirect_uri=${encodeURIComponent(redirectUri)}`;


const Spotify = {
  getAccessToken() {
  if (accessToken) return accessToken;

  const tokenMatch = window.location.href.match(/access_token=([^&]*)/);
  const expiresMatch = window.location.href.match(/expires_in=([^&]*)/);

  if (tokenMatch && expiresMatch) {
    accessToken = tokenMatch[1];
    const expiresIn = Number(expiresMatch[1]);

    window.setTimeout(() => (accessToken = ''), expiresIn * 1000);
    window.history.pushState(null, '', window.location.pathname);

    return accessToken;
  }

  // Don’t redirect from here anymore
    return null;
  },

  search(term) {
    const accessToken = Spotify.getAccessToken();
    return fetch(`https://api.spotify.com/v1/search?type=track&q=${term}`, {
      headers: {
        Authorization: `Bearer ${accessToken}`
      }
    }).then(response => {
      return response.json();
    }).then(jsonResponse => {
      if (!jsonResponse.tracks) {
        return [];
      }
      return jsonResponse.tracks.items.map(track => ({
        id: track.id,
        name: track.name,
        artist: track.artists[0].name,
        album: track.album.name,
        uri: track.uri
      }));
    });
  },

  savePlaylist(name, trackUris) {
    if (!name || !trackUris.length) {
      return;
    }

    const accessToken = Spotify.getAccessToken();
    const headers = { Authorization: `Bearer ${accessToken}` };
    let userId;

    return fetch('https://api.spotify.com/v1/me', {headers: headers}
    ).then(response => response.json()
    ).then(jsonResponse => {
      userId = jsonResponse.id;
      return fetch(`https://api.spotify.com/v1/users/${userId}/playlists`, {
        headers: headers,
        method: 'POST',
        body: JSON.stringify({name: name})
      }).then(response => response.json()
      ).then(jsonResponse => {
        const playlistId = jsonResponse.id;
        return fetch(`https://api.spotify.com/v1/users/${userId}/playlists/${playlistId}/tracks`, {
          headers: headers,
          method: 'POST',
          body: JSON.stringify({uris: trackUris})
        });
      });
    });
  }
};

export { accessUrl };
export default Spotify;
