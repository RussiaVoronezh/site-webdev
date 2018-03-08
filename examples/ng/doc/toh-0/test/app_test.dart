// #docregion , initial
@TestOn('browser')

import 'package:angular/angular.dart';
// import 'package:angular/';
import 'package:angular_test/angular_test.dart';
import 'package:angular_tour_of_heroes/app_component.dart';
import 'package:angular_tour_of_heroes/app_component.template.dart' as app_aot;
import 'package:test/test.dart';

import 'app_test.template.dart' as aot;

@GenerateInjector(const [
  const ClassProvider(Testability, useClass: BrowserGetTestability),
  const ClassProvider(TestabilityRegistry),
  const ClassProvider(AppComponent),
])
final InjectorFactory rootInjectorFactory = aot.rootInjectorFactory$Injector;

void main() {
  // #docregion test-bed-and-fixture
  final testBed = NgTestBed.forComponent<AppComponent>(
    app_aot.AppComponentNgFactory,
    rootInjector: rootInjectorFactory,
  );
  NgTestFixture<AppComponent> fixture;
  // #enddocregion test-bed-and-fixture

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  // #docregion default-test
  test('Default greeting', () {
    expect(fixture.text, 'Hello Angular');
  });
  // #enddocregion default-test, initial

  // #docregion more-tests
  test('Greet world', () async {
    await fixture.update((c) => c.name = 'World');
    expect(fixture.text, 'Hello World');
  });

  test('Greet world HTML', () {
    final html = fixture.rootElement.innerHtml;
    expect(html, '<h1>Hello Angular</h1>');
  });
  // #enddocregion more-tests
  // #docregion initial
}
