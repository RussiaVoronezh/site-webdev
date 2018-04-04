// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart' as paths;
import 'crisis.dart';
import 'crisis_service.dart';

@Component(
  selector: 'my-crises',
  templateUrl: 'crisis_list_component_3.html',
  styleUrls: ['crisis_list_component.css'],
  directives: [coreDirectives],
  providers: [const ClassProvider(CrisisService)],
)
class CrisisListComponent implements OnActivate {
  final CrisisService _crisisService;
  final Router _router;
  List<Crisis> crises;
  Crisis selected;

  CrisisListComponent(this._crisisService, this._router);

  Future<void> _getCrises() async {
    crises = await _crisisService.getAll();
  }

  // #docregion onActivate
  @override
  Future<void> onActivate(_, RouterState current) async {
    await _getCrises();
    selected = _select(current);
  }

  Crisis _select(RouterState routerState) {
    final id = _getId(routerState);
    return id == null
        ? null
        : crises.firstWhere((e) => e.id == id, orElse: () => null);
  }

  // #docregion _getId
  int _getId(RouterState routerState) =>
      int.parse(routerState.queryParameters[paths.idParam] ?? '',
          onError: (_) => null);
  // #enddocregion _getId, onActivate

  // #docregion onSelect, onSelect-_gotoDetail
  void onSelect(Crisis crises) => _gotoDetail(crises.id);
  // #enddocregion onSelect, onSelect-_gotoDetail

  String _crisisUrl(int id) =>
      paths.hero.toUrl(parameters: {paths.idParam: id.toString()});

  // #docregion _gotoDetail, onSelect-_gotoDetail
  Future<NavigationResult> _gotoDetail(int id) =>
      _router.navigate(_crisisUrl(id));
  // #enddocregion _gotoDetail, onSelect-_gotoDetail
}
