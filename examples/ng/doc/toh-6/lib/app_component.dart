// #docplaster
// #docregion
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';
import 'src/hero_service.dart';

@Component(
  selector: 'my-app',
  // #docregion template
  template: '''
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="routes.dashboard.path"
         routerLinkActive="active">Dashboard</a>
      <a [routerLink]="routes.heroes.path"
         routerLinkActive="active">Heroes</a>
    </nav>
    <router-outlet [routes]="routes.all"></router-outlet>
  ''',
  // #enddocregion template
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  providers: [Routes, HeroService],
)
class AppComponent {
  final title = 'Tour of Heroes';
  final Routes routes;

  AppComponent(this.routes);
}
