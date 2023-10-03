enum LocalStorageKey {
  accessToken('access_token'),
  expiresAt('expires_at');

  final String value;

  const LocalStorageKey(this.value);
}
