// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScoreStore on _ScoreStore, Store {
  late final _$matchDataAtom =
      Atom(name: '_ScoreStore.matchData', context: context);

  @override
  MatchModel? get matchData {
    _$matchDataAtom.reportRead();
    return super.matchData;
  }

  @override
  set matchData(MatchModel? value) {
    _$matchDataAtom.reportWrite(value, super.matchData, () {
      super.matchData = value;
    });
  }

  late final _$_ScoreStoreActionController =
      ActionController(name: '_ScoreStore', context: context);

  @override
  void getAllData(String matchId) {
    final _$actionInfo = _$_ScoreStoreActionController.startAction(
        name: '_ScoreStore.getAllData');
    try {
      return super.getAllData(matchId);
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
matchData: ${matchData}
    ''';
  }
}
