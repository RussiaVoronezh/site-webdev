// #docregion token
import 'package:angular/angular.dart';

const appConfigToken = const OpaqueToken('app.config');
// #enddocregion token

// #docregion config
const Map heroDiConfig = const <String,String>{
  'apiEndpoint' : 'api.heroes.com',
  'title' : 'Dependency Injection'
};
// #enddocregion config

// #docregion config-alt
class AppConfig {
  String apiEndpoint;
  String title;
}

AppConfig heroDiConfigFactory() => new AppConfig()
  ..apiEndpoint = 'api.heroes.com'
  ..title = 'Dependency Injection';
// #enddocregion config-alt

const appConfigProvider = const Provider<AppConfig>(appConfigToken,
  useFactory: heroDiConfigFactory,
  deps: []);
