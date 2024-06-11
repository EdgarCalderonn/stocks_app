class AppConfig {
  final String apiHost;
  final String apiKey;

  const AppConfig({
    required this.apiHost,
    required this.apiKey,
  });
}

enum EnvironmentKeys {
  apiHost('API_HOST'),
  apiKey('API_KEY');

  const EnvironmentKeys(this.value);

  final String value;
}
