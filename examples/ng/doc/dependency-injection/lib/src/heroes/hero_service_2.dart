// #docregion
import 'package:angular/angular.dart';

import '../logger_service.dart';
import 'hero.dart';
import 'mock_heroes.dart';

@Injectable()
class HeroService {
  final Logger _logger;

  //#docregion ctor
  HeroService(this._logger);
  //#enddocregion ctor

  List<Hero> getAll() {
    _logger.log('Getting heroes ...');
    return mockHeroes;
  }
}
