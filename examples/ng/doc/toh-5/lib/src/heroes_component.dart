// #docplaster
// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
// #docregion gotoDetail-stub
import 'package:angular_router/angular_router.dart';

// #enddocregion gotoDetail-stub
import 'hero.dart';
import 'hero_service.dart';

// #docregion metadata, pipes, renaming
@Component(
  selector: 'my-heroes',
  // #enddocregion pipes
  templateUrl: 'heroes_component.html',
  styleUrls: const ['heroes_component.css'],
  // #enddocregion renaming
  directives: const [coreDirectives],
  // #docregion pipes
  pipes: const [COMMON_PIPES],
  // #docregion renaming
)
// #enddocregion metadata, pipes
// #docregion class, gotoDetail-stub
class HeroesComponent implements OnInit {
  // #enddocregion renaming, gotoDetail-stub
  final HeroService _heroService;
  final Router _router;
  List<Hero> heroes;
  Hero selectedHero;

  // #docregion renaming
  HeroesComponent(
      this._heroService,
      // #enddocregion renaming
      this._router
      // #docregion renaming
      );
  // #enddocregion renaming

  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  void ngOnInit() => getHeroes();

  void onSelect(Hero hero) => selectedHero = hero;

  // #docregion gotoDetail, gotoDetail-stub
  Future<NavigationResult> gotoDetail() =>
      // #enddocregion gotoDetail-stub
      _router.navigate('/detail/${selectedHero.id}');
  // #enddocregion gotoDetail
  // #docregion renaming, gotoDetail-stub
}
