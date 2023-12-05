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

  late final _$wideAtom = Atom(name: '_ScoreStore.wide', context: context);

  @override
  bool get wide {
    _$wideAtom.reportRead();
    return super.wide;
  }

  @override
  set wide(bool value) {
    _$wideAtom.reportWrite(value, super.wide, () {
      super.wide = value;
    });
  }

  late final _$noBallAtom = Atom(name: '_ScoreStore.noBall', context: context);

  @override
  bool get noBall {
    _$noBallAtom.reportRead();
    return super.noBall;
  }

  @override
  set noBall(bool value) {
    _$noBallAtom.reportWrite(value, super.noBall, () {
      super.noBall = value;
    });
  }

  late final _$byesAtom = Atom(name: '_ScoreStore.byes', context: context);

  @override
  bool get byes {
    _$byesAtom.reportRead();
    return super.byes;
  }

  @override
  set byes(bool value) {
    _$byesAtom.reportWrite(value, super.byes, () {
      super.byes = value;
    });
  }

  late final _$legByesAtom =
      Atom(name: '_ScoreStore.legByes', context: context);

  @override
  bool get legByes {
    _$legByesAtom.reportRead();
    return super.legByes;
  }

  @override
  set legByes(bool value) {
    _$legByesAtom.reportWrite(value, super.legByes, () {
      super.legByes = value;
    });
  }

  late final _$wicketAtom = Atom(name: '_ScoreStore.wicket', context: context);

  @override
  bool get wicket {
    _$wicketAtom.reportRead();
    return super.wicket;
  }

  @override
  set wicket(bool value) {
    _$wicketAtom.reportWrite(value, super.wicket, () {
      super.wicket = value;
    });
  }

  late final _$inningOneAtom =
      Atom(name: '_ScoreStore.inningOne', context: context);

  @override
  InningModel? get inningOne {
    _$inningOneAtom.reportRead();
    return super.inningOne;
  }

  @override
  set inningOne(InningModel? value) {
    _$inningOneAtom.reportWrite(value, super.inningOne, () {
      super.inningOne = value;
    });
  }

  late final _$inningTwoAtom =
      Atom(name: '_ScoreStore.inningTwo', context: context);

  @override
  InningModel? get inningTwo {
    _$inningTwoAtom.reportRead();
    return super.inningTwo;
  }

  @override
  set inningTwo(InningModel? value) {
    _$inningTwoAtom.reportWrite(value, super.inningTwo, () {
      super.inningTwo = value;
    });
  }

  late final _$currentInningAtom =
      Atom(name: '_ScoreStore.currentInning', context: context);

  @override
  InningModel? get currentInning {
    _$currentInningAtom.reportRead();
    return super.currentInning;
  }

  @override
  set currentInning(InningModel? value) {
    _$currentInningAtom.reportWrite(value, super.currentInning, () {
      super.currentInning = value;
    });
  }

  late final _$extraRunAtom =
      Atom(name: '_ScoreStore.extraRun', context: context);

  @override
  ExtraRunModel? get extraRun {
    _$extraRunAtom.reportRead();
    return super.extraRun;
  }

  @override
  set extraRun(ExtraRunModel? value) {
    _$extraRunAtom.reportWrite(value, super.extraRun, () {
      super.extraRun = value;
    });
  }

  late final _$strikerAtom =
      Atom(name: '_ScoreStore.striker', context: context);

  @override
  BattingLineUpModel? get striker {
    _$strikerAtom.reportRead();
    return super.striker;
  }

  @override
  set striker(BattingLineUpModel? value) {
    _$strikerAtom.reportWrite(value, super.striker, () {
      super.striker = value;
    });
  }

  late final _$nonStrikerAtom =
      Atom(name: '_ScoreStore.nonStriker', context: context);

  @override
  BattingLineUpModel? get nonStriker {
    _$nonStrikerAtom.reportRead();
    return super.nonStriker;
  }

  @override
  set nonStriker(BattingLineUpModel? value) {
    _$nonStrikerAtom.reportWrite(value, super.nonStriker, () {
      super.nonStriker = value;
    });
  }

  late final _$bowlerAtom = Atom(name: '_ScoreStore.bowler', context: context);

  @override
  BowlingLineUpModel? get bowler {
    _$bowlerAtom.reportRead();
    return super.bowler;
  }

  @override
  set bowler(BowlingLineUpModel? value) {
    _$bowlerAtom.reportWrite(value, super.bowler, () {
      super.bowler = value;
    });
  }

  late final _$currentOverAtom =
      Atom(name: '_ScoreStore.currentOver', context: context);

  @override
  List<int> get currentOver {
    _$currentOverAtom.reportRead();
    return super.currentOver;
  }

  @override
  set currentOver(List<int> value) {
    _$currentOverAtom.reportWrite(value, super.currentOver, () {
      super.currentOver = value;
    });
  }

  late final _$isLoadAtom = Atom(name: '_ScoreStore.isLoad', context: context);

  @override
  bool get isLoad {
    _$isLoadAtom.reportRead();
    return super.isLoad;
  }

  @override
  set isLoad(bool value) {
    _$isLoadAtom.reportWrite(value, super.isLoad, () {
      super.isLoad = value;
    });
  }

  late final _$targetAtom = Atom(name: '_ScoreStore.target', context: context);

  @override
  int get target {
    _$targetAtom.reportRead();
    return super.target;
  }

  @override
  set target(int value) {
    _$targetAtom.reportWrite(value, super.target, () {
      super.target = value;
    });
  }

  late final _$totalRunAtom =
      Atom(name: '_ScoreStore.totalRun', context: context);

  @override
  int get totalRun {
    _$totalRunAtom.reportRead();
    return super.totalRun;
  }

  @override
  set totalRun(int value) {
    _$totalRunAtom.reportWrite(value, super.totalRun, () {
      super.totalRun = value;
    });
  }

  late final _$totalBallAtom =
      Atom(name: '_ScoreStore.totalBall', context: context);

  @override
  int get totalBall {
    _$totalBallAtom.reportRead();
    return super.totalBall;
  }

  @override
  set totalBall(int value) {
    _$totalBallAtom.reportWrite(value, super.totalBall, () {
      super.totalBall = value;
    });
  }

  late final _$newBowlerAtom =
      Atom(name: '_ScoreStore.newBowler', context: context);

  @override
  String get newBowler {
    _$newBowlerAtom.reportRead();
    return super.newBowler;
  }

  @override
  set newBowler(String value) {
    _$newBowlerAtom.reportWrite(value, super.newBowler, () {
      super.newBowler = value;
    });
  }

  late final _$selectNewBowlerAsyncAction =
      AsyncAction('_ScoreStore.selectNewBowler', context: context);

  @override
  Future<void> selectNewBowler() {
    return _$selectNewBowlerAsyncAction.run(() => super.selectNewBowler());
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
  void changeWide() {
    final _$actionInfo = _$_ScoreStoreActionController.startAction(
        name: '_ScoreStore.changeWide');
    try {
      return super.changeWide();
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNoball() {
    final _$actionInfo = _$_ScoreStoreActionController.startAction(
        name: '_ScoreStore.changeNoball');
    try {
      return super.changeNoball();
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLegbyes() {
    final _$actionInfo = _$_ScoreStoreActionController.startAction(
        name: '_ScoreStore.changeLegbyes');
    try {
      return super.changeLegbyes();
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeByes() {
    final _$actionInfo = _$_ScoreStoreActionController.startAction(
        name: '_ScoreStore.changeByes');
    try {
      return super.changeByes();
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void countRun(int run) {
    final _$actionInfo =
        _$_ScoreStoreActionController.startAction(name: '_ScoreStore.countRun');
    try {
      return super.countRun(run);
    } finally {
      _$_ScoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
matchData: ${matchData},
wide: ${wide},
noBall: ${noBall},
byes: ${byes},
legByes: ${legByes},
wicket: ${wicket},
inningOne: ${inningOne},
inningTwo: ${inningTwo},
currentInning: ${currentInning},
extraRun: ${extraRun},
striker: ${striker},
nonStriker: ${nonStriker},
bowler: ${bowler},
currentOver: ${currentOver},
isLoad: ${isLoad},
target: ${target},
totalRun: ${totalRun},
totalBall: ${totalBall},
newBowler: ${newBowler}
    ''';
  }
}
