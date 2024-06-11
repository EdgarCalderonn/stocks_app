import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stocks_app/core/domain/entities/app_config.dart';

import 'app_modules.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureInjection() async {
  /// Inject dependencies
  await getIt.init();
}

@module
abstract class EnvironmentInjection {
  @singleton
  @preResolve
  Future<AppConfig> appConfig() => getEnvironmentConfig();

  @singleton
  Dio get dioClient => Dio();
}

Future<AppConfig> getEnvironmentConfig() async {
  await dotenv.load(fileName: '.env');

  final config = AppConfig(
    apiHost: dotenv.env[EnvironmentKeys.apiHost.value]!,
    apiKey: dotenv.env[EnvironmentKeys.apiKey.value]!,
  );

  return config;
}
