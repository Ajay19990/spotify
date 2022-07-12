class AuthConstants {
  static const clientID = '6699f3ea6e2a4541943a21ffbe75b787';
  static const clientSecret = '9844a82e77a0456ba21bc1073961b221';
  static const redirectUrl = 'https://iosacademy.io/callback/';
  static const tokenApiUrl = 'https://accounts.spotify.com/api/token';

  static const scopes =
      "ugc-image-upload%20user-modify-playback-state%20user-read-playback-state%20user-read-currently-playing%20user-follow-modify%20user-follow-read%20user-read-recently-played%20user-read-playback-position%20user-top-read%20playlist-read-collaborative%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20app-remote-control%20streaming%20user-read-email%20user-read-private%20user-read-private%20user-library-modify%20user-library-read";

  static get signinInitialUrl {
    const url =
        'https://accounts.spotify.com/authorize?response_type=code&client_id=${AuthConstants.clientID}&redirect_uri=${AuthConstants.redirectUrl}&scope=${AuthConstants.scopes}&show_dialog=true';
    return url;
  }

  static const accessTokenKey = 'access_token_key';
  static const refreshTokenKey = 'refresh_token_key';
  static const expiresInKey = 'expires_in_key'; 
}
