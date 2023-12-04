import 'package:cric_spot/model/batting/batting_lineup_model.dart';
import 'package:cric_spot/model/bowling/bowling_lineup_model.dart';
import 'package:cric_spot/model/extra/extra_run_model.dart';
import 'package:cric_spot/model/inning/inning_model.dart';
import 'package:cric_spot/model/match/match_model.dart';
import 'package:cric_spot/model/player/player_model.dart';
import 'package:cric_spot/model/team/team_model.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'score_store.g.dart';

class ScoreStore = _ScoreStore with _$ScoreStore;

abstract class _ScoreStore with Store {
  Box<PlayerModel> playerBox;
  Box<TeamModel> teamBox;
  Box<MatchModel> matchBox;
  Box<InningModel> inningBox;

  _ScoreStore(this.playerBox, this.teamBox, this.matchBox, this.inningBox);

  @observable
  MatchModel? matchData;

  @observable
  bool wide = false;

  @observable
  bool noBall = false;

  @observable
  bool byes = false;

  @observable
  bool legByes = false;

  @observable
  bool wicket = false;

  @observable
  InningModel? inningOne;

  @observable
  InningModel? inningTwo;

  @observable
  InningModel? currentInning;

  @observable
  ExtraRunModel? extraRun;

  @observable
  BattingLineUpModel? striker;

  @observable
  BattingLineUpModel? nonStriker;

  @observable
  BowlingLineUpModel? bowler;

  @observable
  List<int> currentOver = [];

  @observable
  bool isLoad = false;

  @observable
  int target = 0;

  @observable
  int totalRun = 0;

  @observable
  int totalBall = 0;

  @action
  void getAllData(String matchId) {
    isLoad = true;
    matchData = matchBox.get(int.parse(matchId));
    inningOne = inningBox.get(int.parse(matchData!.inningOneId!));
    inningTwo = inningBox.get(int.parse(matchData!.inningTwoId!));
    if (inningOne!.totalBall! == (int.parse(matchData!.over!) * 6)) {
      currentInning = inningTwo;
      target = inningOne!.totalRun! + 1;
    } else {
      currentInning = inningOne;
    }
    totalRun = currentInning!.totalRun!;
    totalBall = currentInning!.totalBall!;
    extraRun = currentInning?.extraRun;
    striker = currentInning?.currentStriker;
    nonStriker = currentInning?.currentNonStriker;
    bowler = currentInning?.currentBowler;
    currentOver = currentInning?.currentOver ?? [];
    isLoad = false;
  }

  @action
  void changeWide() {
    wide = !wide;
    noBall = false;
    legByes = false;
    byes = false;
  }

  @action
  void changeNoball() {
    noBall = !noBall;
    wide = false;
  }

  @action
  void changeLegbyes() {
    legByes = !legByes;
    wide = false;
    byes = false;
  }

  @action
  void changeByes() {
    byes = !byes;
    wide = false;
    legByes = false;
  }

  @action
  void countOne() {
    currentOver.add(1);
    // currentOver = currentOver;
    totalRun = totalRun + 1;
    totalBall = totalBall + 1;
    // currentInning!.totalRun = totalRun;
    currentInning!.totalRun = currentInning!.totalRun! + 1;
    currentInning!.totalBall = currentInning!.totalBall! + 1;
    currentInning = currentInning;

    bowler!.ball = bowler!.ball! + 1;
    bowler!.run = bowler!.run! + 1;
    bowler = bowler;

    striker!.ball = striker!.ball! + 1;
    striker!.run = striker!.run! + 1;
    final change = striker;
    striker = nonStriker;
    nonStriker = change;

    // ss
    // final List<BattingLineUpModel> updateBattingLineUpList =
    //     currentInning!.battingLineup!.map((e) {
    //   if (e.playerId == striker!.playerId) {
    //     return striker;
    //   }
    //   return e;
    // }).toList();

    // currentInning!.battingLineup!.map((e) {
    //   if (e.playerId == striker!.playerId) {
    //     return striker;
    //   }
    //   if (e.playerId == nonStriker!.playerId) {
    //     return nonStriker;
    //   }
    //   return e;
    // }).toList();

    // currentInning!.battingLineup = updateBattingLineUpList;
  }
}
