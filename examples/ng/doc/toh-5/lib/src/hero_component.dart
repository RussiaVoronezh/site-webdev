// #docplaster
// #docregion , v2
// #docregion added-imports
import 'dart:async';

// #enddocregion added-imports
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
// #docregion added-imports
import 'package:angular_router/angular_router.dart';

// #enddocregion added-imports
import 'hero.dart';
// #docregion added-imports
import 'hero_service.dart';
import 'route_paths.dart' as paths;
// #enddocregion added-imports

// #docregion metadata, metadata-wo-style
@Component(
  selector: 'my-hero',
  // #docregion templateUrl
  templateUrl: 'hero_component.html',
  // #enddocregion metadata-wo-style, templateUrl, v2
  styleUrls: ['hero_component.css'],
  // #docregion metadata-wo-style
  directives: [coreDirectives, formDirectives],
  // #docregion v2
)
// #enddocregion metadata, metadata-wo-style
// #docregion OnActivate, hero
class HeroComponent implements OnActivate {
  // #enddocregion OnActivate
  Hero hero;
  // #enddocregion hero
  // #docregion ctor
  final HeroService _heroService;
  final Location _location;

  HeroComponent(this._heroService, this._location);
  // #enddocregion ctor

  // #docregion OnActivate
  @override
  Future<void> onActivate(_, RouterState current) async {
    final id = _getId(current);
    if (id != null) hero = await (_heroService.get(id));
  }

  int _getId(RouterState routerState) => int
      .parse(routerState.parameters[paths.idParam] ?? '', onError: (_) => null);
  // #enddocregion OnActivate

  // #docregion goBack
  void goBack() => _location.back();
  // #enddocregion goBack
  // #docregion hero, OnActivate
}
