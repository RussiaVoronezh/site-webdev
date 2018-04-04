// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart' as paths;
import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-hero',
  templateUrl: 'hero_component.html',
  styleUrls: ['hero_component.css'],
  directives: [coreDirectives, formDirectives],
)
class HeroComponent implements OnActivate {
  Hero hero;
  final HeroService _heroService;
  // #docregion router
  final Router _router;

  HeroComponent(this._heroService, this._router);
  // #enddocregion router

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
  Future<NavigationResult> goBack() => _router.navigate(
      paths.heroes.toUrl(),
      new NavigationParams(
          queryParameters: {paths.idParam: hero.id.toString()}));
  // #enddocregion goBack
}
