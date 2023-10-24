enum LocalStorageKey {
  accessToken('access_token'),
  expiresAt('expires_at'),

  taskRefreshTokenId('task_refresh_token_id');

  final String value;

  const LocalStorageKey(this.value);
}
