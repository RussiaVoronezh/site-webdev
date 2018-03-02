// #docregion
@TestOn('browser')

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_tour_of_heroes/src/app_routes.dart';
import 'package:angular_tour_of_heroes/src/dashboard_component.dart';
import 'package:angular_tour_of_heroes/src/hero_service.dart';
import 'package:test/test.dart';

import 'dashboard_po.dart';
import 'matchers.dart';
import 'utils.dart';

// #docregion providers-with-context
NgTestFixture<TestComponent> fixture;
DashboardPO po;
Router router;

void main() {
  final injector = new InjectorProbe();
  final testBed = new NgTestBed<TestComponent>().addProviders([
    const ClassProvider(HeroService),
    routerProvidersForTesting,
  ]).addInjector(injector.init);
  // #enddocregion providers-with-context

  // #docregion setUp
  List<RouterState> navHistory;

  setUp(() async {
    fixture = await testBed.create();
    router = fixture.assertOnlyInstance.router;
    navHistory = [];
    router.stream.listen((newState) => navHistory.add(newState));
    po = await new DashboardPO().resolve(fixture);
  });
  // #enddocregion setUp

  tearDown(disposeAnyRunningTest);

  test('title', () async {
    expect(await po.title, 'Top Heroes');
  });

  test('show top heroes', () async {
    final expectedNames = ['Narco', 'Bombasto', 'Celeritas', 'Magneta'];
    expect(await po.heroNames, expectedNames);
  });

  // #docregion go-to-detail
  test('select hero and navigate to detail + navHistory', () async {
    await po.selectHero(3);
    await fixture.update();
    expect(navHistory.length, 1);
    expect(navHistory[0].path, '/detail/15');
    // Or, using a custom matcher:
    expect(navHistory[0], isRouterState('/detail/15'));
  });
  // #enddocregion go-to-detail

  // #docregion go-to-detail-alt
  test('select hero and navigate to detail + mock platform location', () async {
    await po.selectHero(3);
    await fixture.update();
    final mockLocation = injector.get<MockPlatformLocation>(PlatformLocation);
    expect(mockLocation.pathname, '/detail/15');
  });
  // #enddocregion go-to-detail-alt
  // #docregion providers-with-context
}
// #enddocregion providers-with-context

// #docregion TestComponent
@Component(
  selector: 'test',
  template: '''
    <my-dashboard></my-dashboard>
    <router-outlet [routes]="[routes.heroDetail]"></router-outlet>
  ''',
  directives: const [RouterOutlet, DashboardComponent],
  providers: const [AppRoutes],
)
class TestComponent {
  final AppRoutes routes;
  final Router router;
  TestComponent(this.routes, this.router);
}
