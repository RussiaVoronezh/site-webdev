// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../instance_logger.dart';
import 'crisis.dart';
import 'crisis_service.dart';
import 'dialog_service.dart';
import 'route_paths.dart' as paths;

@Component(
  selector: 'my-crisis',
  templateUrl: 'crisis_component.html',
  styleUrls: ['crisis_component.css'],
  directives: [coreDirectives, formDirectives],
)
// #docregion CanReuse
class CrisisComponent extends Object
    with CanReuse, InstanceLogger
    implements CanDeactivate, OnActivate, OnDeactivate {
  // #enddocregion CanReuse
  Crisis crisis;
  String name;
  final CrisisService _crisisService;
  final Router _router;
  final DialogService _dialogService;
  String get loggerPrefix => 'CrisisComponent';

  // #docregion OnActivate-and-OnDeactivate
  CrisisComponent(this._crisisService, this._router, this._dialogService) {
    log('created');
  }
  // #enddocregion OnActivate-and-OnDeactivate

  @override
  // #docregion onActivate, OnActivate-and-OnDeactivate
  Future<void> onActivate(_, RouterState current) async {
    // #enddocregion onActivate
    log('onActivate: ${_?.toUrl()} -> ${current?.toUrl()}');
    // #enddocregion OnActivate-and-OnDeactivate
    // #docregion onActivate
    final id = _getId(current);
    if (id == null) return null;
    crisis = await (_crisisService.get(id));
    name = crisis?.name;
    log('onActivate: set name = $name');
    // #docregion OnActivate-and-OnDeactivate
  }
  // #enddocregion onActivate, OnActivate-and-OnDeactivate

  @override
  // #docregion onDeactivate, OnActivate-and-OnDeactivate
  void onDeactivate(RouterState current, _) {
    log('onDeactivate: ${current?.toUrl()} -> ${_?.toUrl()}');
  }
  // #enddocregion onDeactivate, OnActivate-and-OnDeactivate

  int _getId(RouterState routerState) => int
      .parse(routerState.parameters[paths.idParam] ?? '', onError: (_) => null);

  // #docregion save
  Future<void> save() async {
    log('save: $name (was ${crisis?.name}');
    crisis?.name = name;
    goBack();
  }
  // #enddocregion save

  // #docregion goBack
  Future<NavigationResult> goBack() => _router.navigate(paths.home.toUrl());
  // #enddocregion goBack

  @override
  // #docregion canDeactivate
  Future<bool> canDeactivate(RouterState prev, RouterState next) async {
    log('canDeactivate: ${prev?.toUrl()} -> ${next?.toUrl()}; ${crisis?.name} == $name?');
    return crisis == null || crisis?.name == name
        ? true
        : _dialogService.confirm('Discard changes?');
  }
  // #enddocregion canDeactivate
  // #docregion CanReuse
}
