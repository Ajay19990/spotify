class HomeConstants {
  static const baseUrl = 'https://api.spotify.com/v1';
  static get newAlbumsUrl {
    const url = '$baseUrl/browse/new-releases';
    return url;
  }
}
