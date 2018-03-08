// #docregion
@TestOn('browser')
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_tour_of_heroes/app_component.dart';
import 'package:angular_tour_of_heroes/app_component.template.dart' as app_aot;
import 'package:pageloader/objects.dart';
import 'package:test/test.dart';

import 'app_test.template.dart' as aot;

// #docregion AppPO, AppPO-initial, AppPO-hero, AppPO-input
class AppPO extends PageObjectBase {
  // #enddocregion AppPO-hero, AppPO-input
  @ByTagName('h1')
  PageLoaderElement get _title => q('h1');
  // #enddocregion AppPO-initial

  // #docregion AppPO-hero
  @FirstByCss('div')
  PageLoaderElement get _id => q('div'); // e.g. 'id: 1'

  @ByTagName('h2')
  PageLoaderElement get _heroName => q('h2'); // e.g. 'Mr Freeze details!'
  // #enddocregion AppPO-hero

  // #docregion AppPO-input
  @ByTagName('input')
  PageLoaderElement get _input => q('input');
  // #enddocregion AppPO-input

  // #docregion AppPO-initial
  Future<String> get title => _title.visibleText;
  // #enddocregion AppPO-initial

  // #docregion AppPO-hero
  Future<int> get heroId async {
    final idAsString = (await _id.visibleText).split(':')[1];
    return int.parse(idAsString, onError: (_) => -1);
  }

  Future<String> get heroName async {
    final text = await _heroName.visibleText;
    return text.substring(0, text.lastIndexOf(' '));
  }
  // #enddocregion AppPO-hero

  // #docregion AppPO-input
  Future type(String s) => _input.type(s);
  // #docregion AppPO-initial, AppPO-hero
}
// #enddocregion AppPO, AppPO-initial, AppPO-hero, AppPO-input

@GenerateInjector(const [
  const ClassProvider(AppComponent),
])
final InjectorFactory rootInjectorFactory = aot.rootInjectorFactory$Injector;

void main() {
  // #docregion appPO-setup
  final testBed = NgTestBed.forComponent<AppComponent>(
    app_aot.AppComponentNgFactory,
    rootInjector: rootInjectorFactory,
  );
  NgTestFixture<AppComponent> fixture;
  AppPO appPO;

  setUp(() async {
    fixture = await testBed.create();
    appPO = await new AppPO().resolve(fixture);
  });
  // #enddocregion appPO-setup

  tearDown(disposeAnyRunningTest);

  // #docregion title
  test('title', () async {
    expect(await appPO.title, 'Tour of Heroes');
  });
  // #enddocregion title

  // #docregion hero
  const windstormData = const <String, dynamic>{'id': 1, 'name': 'Windstorm'};

  test('initial hero properties', () async {
    expect(await appPO.heroId, windstormData['id']);
    expect(await appPO.heroName, windstormData['name']);
  });
  // #enddocregion hero

  // #docregion update-name
  const nameSuffix = 'X';

  test('update hero name', () async {
    await appPO.type(nameSuffix);
    expect(await appPO.heroId, windstormData['id']);
    expect(await appPO.heroName, windstormData['name'] + nameSuffix);
  });
  // #enddocregion update-name
}
