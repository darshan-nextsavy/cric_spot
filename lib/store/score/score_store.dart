import 'package:cric_spot/core/enum/run_count_type.dart';
import 'package:cric_spot/core/enum/wicket_type.dart';
import 'package:cric_spot/model/batting/batting_lineup_model.dart';
import 'package:cric_spot/model/bowling/bowling_lineup_model.dart';
import 'package:cric_spot/model/extra/extra_run_model.dart';
import 'package:cric_spot/model/inning/inning_model.dart';
import 'package:cric_spot/model/match/match_model.dart';
import 'package:cric_spot/model/partnership/partnership_model.dart';
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

  @observable
  int overLength = 0;

  @observable
  String newBowler = '';

  @observable
  String newBatsman = '';

  @observable
  WicketType wicketType = WicketType.bowled;

  @observable
  RunCountType runCountType = RunCountType.noramlRun;

  @observable
  bool scoreBoardOneIsOpen = true;

  @observable
  bool scoreBoardTwoIsOpen = true;

  @action
  void getAllData(String matchId) {
    isLoad = true;
    if (matchData == null || matchData!.id != matchId) {
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
      overLength = currentOver.length;
    }

    isLoad = false;
  }

  @action
  Future<void> selectNewBowler() async {
    // save bowler player
    PlayerModel newBowlerData = PlayerModel(name: newBowler);
    final bowlerId = await playerBox.add(newBowlerData);
    newBowlerData.id = bowlerId.toString();
    newBowlerData.save();

    currentInning!.bowlingLineup!.add(BowlingLineUpModel(
        playerId: bowlerId.toString(),
        name: newBowler,
        run: 0,
        ball: 0,
        wicket: 0,
        maidan: 0));
    currentInning!.currentBowler = BowlingLineUpModel(
        playerId: bowlerId.toString(),
        name: newBowler,
        run: 0,
        ball: 0,
        wicket: 0,
        maidan: 0);
    currentInning!.overs!.add(currentOver);
    currentInning!.currentOver = [];
    currentInning = currentInning;
    if (currentInning!.isFirstInning!) {
      inningOne = currentInning;
    } else {
      inningTwo = currentInning;
    }
    bowler = currentInning!.currentBowler;
    currentOver = [];
    overLength = 0;
    newBowler = '';
  }

  @action
  Future<PlayerModel> fallOfWicket() async {
    PlayerModel newBatsmanData = PlayerModel(name: newBatsman);
    final batsmanId = await playerBox.add(newBatsmanData);
    newBatsmanData.id = batsmanId.toString();
    newBatsmanData.save();
    return newBatsmanData;
  }

  @action
  void changeWide() {
    wide = !wide;
    noBall = false;
    legByes = false;
    byes = false;
    selectRunType();
  }

  @action
  void changeNoball() {
    noBall = !noBall;
    wide = false;
    selectRunType();
  }

  @action
  void changeLegbyes() {
    legByes = !legByes;
    wide = false;
    byes = false;
    selectRunType();
  }

  @action
  void changeByes() {
    byes = !byes;
    wide = false;
    legByes = false;
    selectRunType();
  }

  @action
  void changeWicket() {
    wicket = !wicket;
    selectRunType();
  }

  @action
  void selectRunType() {
    if (wicket && wide) {
      runCountType = RunCountType.wideBallWithWicket;
    } else if (noBall && wicket && legByes) {
      runCountType = RunCountType.noBallWithLegByesWithWicket;
    } else if (noBall && wicket && byes) {
      runCountType = RunCountType.noBallWithByesWithWicket;
    } else if (noBall && wicket) {
      runCountType = RunCountType.noBallWithWicket;
    } else if (legByes && wicket) {
      runCountType = RunCountType.legByesWithWicket;
    } else if (byes && wicket) {
      runCountType = RunCountType.byesWithWicket;
    } else if (byes && noBall) {
      runCountType = RunCountType.noBallWithByes;
    } else if (legByes && noBall) {
      runCountType = RunCountType.noBallWithLegByes;
    } else if (wide) {
      runCountType = RunCountType.wideBall;
    } else if (noBall) {
      runCountType = RunCountType.noBall;
    } else if (byes) {
      runCountType = RunCountType.byes;
    } else if (legByes) {
      runCountType = RunCountType.legByes;
    } else if (wicket) {
      runCountType = RunCountType.normalWicket;
    } else {
      runCountType = RunCountType.noramlRun;
    }
  }

  @action
  void countRun({required int run, BattingLineUpModel? newPlayer}) {
    /// switch case for extra run
    print(runCountType);
    print(run);
    switch (runCountType) {
      case RunCountType.noramlRun:
        print("this is 1 = " + striker.toString());

        /// increse over length
        overLength = overLength + 1;

        /// add run to current over
        currentOver.add(run);
        // currentOver = currentOver;
        print("this is 2 = " + striker.toString());

        /// add total run and ball
        totalRun = totalRun + run;
        totalBall = totalBall + 1;
        print("this is 3 = " + striker.toString());

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run;
        currentInning!.totalBall = currentInning!.totalBall! + 1;
        print("this is 4 = " + striker.toString());

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + 1;
        bowler!.run = bowler!.run! + run;
        bowler = bowler;
        print("this is 5 = " + striker.toString());

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;
        striker!.run = striker!.run! + run;
        if (run == 4) {
          striker!.four = striker!.four! + 1;
        }
        if (run == 6) {
          striker!.six = striker!.six! + 1;
        }
        print("this is 6 = " + striker.toString());

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;
        print("this is 7 = " + striker.toString());

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;
        print("this is 8 = " + striker.toString());
        print("this is 8 partnership = " +
            currentInning!.currentPartnerShip.toString());

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.run =
            currentInning!.currentPartnerShip!.currentStiker!.run! + run;
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;
        print("this is 9 = " + striker.toString());
        print("this is 9 partnership = " +
            currentInning!.currentPartnerShip.toString());

        ///0 update current inning
        currentInning = currentInning;
        print("this is 10 = " + striker.toString());

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        print("this is 11 = " + striker.toString());

        break;
      case RunCountType.wideBall:
        int reBallNum = matchData!.isWideReball! ? 0 : 1;
        int wideBallRun = matchData!.wideRun!;

        overLength = overLength + reBallNum;

        /// add extra run
        extraRun!.total = extraRun!.total! + wideBallRun;
        extraRun!.wide = extraRun!.wide! + wideBallRun;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run + matchData!.wideRun!);
        // currentOver = currentOver;

        /// add total run and ball
        totalRun = totalRun + run + wideBallRun;
        totalBall = totalBall + reBallNum;

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run + wideBallRun;
        currentInning!.totalBall = currentInning!.totalBall! + reBallNum;

        /// add run and ball to bowler
        bowler!.run = bowler!.run! + run + wideBallRun;
        bowler!.ball = bowler!.ball! + reBallNum;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + reBallNum;

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + reBallNum;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + reBallNum;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        changeWide();
        break;
      case RunCountType.noBall:
        int reBallNum = matchData!.isNoballReball! ? 0 : 1;
        int noBallRun = matchData!.noballRun!;

        overLength = overLength + reBallNum;

        /// add extra run
        extraRun!.total = extraRun!.total! + noBallRun;
        extraRun!.noBall = extraRun!.noBall! + noBallRun;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run + noBallRun);
        // currentOver = currentOver;

        /// add total run and ball
        totalRun = totalRun + run + noBallRun;
        totalBall = totalBall + reBallNum;

        /// add total run and ball to current inning
        // currentInning!.totalRun = totalRun;
        currentInning!.totalRun = currentInning!.totalRun! + run + noBallRun;
        currentInning!.totalBall = currentInning!.totalBall! + reBallNum;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + reBallNum;
        bowler!.run = bowler!.run! + run + noBallRun;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;
        striker!.run = striker!.run! + run;
        if (run == 4) {
          striker!.four = striker!.four! + 1;
        }
        if (run == 6) {
          striker!.six = striker!.six! + 1;
        }

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run + noBallRun;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.run =
            currentInning!.currentPartnerShip!.currentStiker!.run! + run;
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        changeNoball();
        break;
      case RunCountType.byes:

        /// increse over length
        overLength = overLength + 1;

        /// add extra run
        extraRun!.total = extraRun!.total! + run;
        extraRun!.by = extraRun!.by! + run;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run);

        /// add total run and ball
        totalRun = totalRun + run;
        totalBall = totalBall + 1;

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run;
        currentInning!.totalBall = currentInning!.totalBall! + 1;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + 1;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        changeByes();
        break;
      case RunCountType.legByes:

        /// increse over length
        overLength = overLength + 1;

        /// add extra run
        extraRun!.total = extraRun!.total! + run;
        extraRun!.legBy = extraRun!.legBy! + run;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run);

        /// add total run and ball
        totalRun = totalRun + run;
        totalBall = totalBall + 1;

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run;
        currentInning!.totalBall = currentInning!.totalBall! + 1;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + 1;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        changeLegbyes();
        break;
      case RunCountType.noBallWithByes:
        int reBallNum = matchData!.isNoballReball! ? 0 : 1;
        int noBallRun = matchData!.noballRun!;

        overLength = overLength + reBallNum;

        /// add extra run
        extraRun!.total = extraRun!.total! + run + noBallRun;
        extraRun!.noBall = extraRun!.noBall! + run + noBallRun;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run);

        /// add total run and ball
        totalRun = totalRun + run + noBallRun;
        totalBall = totalBall + reBallNum;

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run + noBallRun;
        currentInning!.totalBall = currentInning!.totalBall! + reBallNum;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + reBallNum;
        bowler!.run = bowler!.run! + run + noBallRun;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run + noBallRun;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        break;
      case RunCountType.noBallWithLegByes:
        int reBallNum = matchData!.isNoballReball! ? 0 : 1;
        int noBallRun = matchData!.noballRun!;

        overLength = overLength + reBallNum;

        /// add extra run
        extraRun!.total = extraRun!.total! + run + noBallRun;
        extraRun!.noBall = extraRun!.noBall! + run + noBallRun;
        extraRun = extraRun;
        currentInning!.extraRun = extraRun;

        /// add run to current over
        currentOver.add(run);

        /// add total run and ball
        totalRun = totalRun + run + noBallRun;
        totalBall = totalBall + reBallNum;

        /// add total run and ball to current inning
        currentInning!.totalRun = currentInning!.totalRun! + run + noBallRun;
        currentInning!.totalBall = currentInning!.totalBall! + reBallNum;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + reBallNum;
        bowler!.run = bowler!.run! + run + noBallRun;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;

        /// add stiker and not stiker data to current inning
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run + noBallRun;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        ///0 update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        break;
      case RunCountType.wideBallWithWicket:
        break;
      case RunCountType.noBallWithWicket:
        break;
      case RunCountType.byesWithWicket:
        break;
      case RunCountType.legByesWithWicket:
        break;
      case RunCountType.noBallWithByesWithWicket:
        break;
      case RunCountType.noBallWithLegByesWithWicket:
        break;
      case RunCountType.normalWicket:

        /// increse over length
        overLength = overLength + 1;

        /// add run to current over
        currentOver.add(00);
        // currentOver = currentOver;

        /// add total run and ball
        totalBall = totalBall + 1;

        /// add total run and ball to current inning
        // currentInning!.totalRun = totalRun;
        currentInning!.totalBall = currentInning!.totalBall! + 1;
        currentInning!.totalWicket = currentInning!.totalWicket! + 1;

        /// add run and ball to bowler
        bowler!.ball = bowler!.ball! + 1;
        bowler!.wicket = bowler!.wicket! + 1;
        bowler = bowler;

        /// add run and ball to batsman
        striker!.ball = striker!.ball! + 1;
        striker!.run = striker!.run! + run;
        striker!.outBy = bowler!.name;
        striker!.outType = wicketType.name;
        striker!.isNotOut = false;
        lastSave();

        /// add stiker and not stiker data to current inning
        striker = newPlayer;
        currentInning!.currentStriker = striker;
        currentInning!.currentNonStriker = nonStriker;
        currentInning!.battingLineup!.add(newPlayer!);

        /// add total run and ball to partnership
        currentInning!.currentPartnerShip!.run =
            currentInning!.currentPartnerShip!.run! + run;
        currentInning!.currentPartnerShip!.ball =
            currentInning!.currentPartnerShip!.ball! + 1;

        /// add run and ball to partnership player
        currentInning!.currentPartnerShip!.currentStiker!.run =
            currentInning!.currentPartnerShip!.currentStiker!.run! + run;
        currentInning!.currentPartnerShip!.currentStiker!.ball =
            currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

        /// create new partnership
        final newPartnership = PartnerShipModel(
            id: newPlayer.playerId.toString(),
            run: 0,
            ball: 0,
            currentStiker: newPlayer,
            currentNotStiker: BattingLineUpModel(
                playerId: nonStriker!.playerId.toString(),
                name: nonStriker!.name,
                run: 0,
                ball: 0,
                four: 0,
                six: 0,
                isNotOut: true));
        lastSavePartnership();
        currentInning!.partnerShips!.add(newPartnership);
        currentInning!.currentPartnerShip = newPartnership;

        /// update current inning
        currentInning = currentInning;

        /// strike rotation
        if ((run % 2 != 0 && overLength != 6) ||
            (overLength == 6 && run % 2 == 0)) {
          /// change striker and non striker
          final change = striker;
          striker = nonStriker;
          nonStriker = change;

          /// change partner striker and non striker in partner ship
          final partnershipChange =
              currentInning!.currentPartnerShip!.currentStiker;
          currentInning!.currentPartnerShip!.currentStiker =
              currentInning!.currentPartnerShip!.currentNotStiker;
          currentInning!.currentPartnerShip!.currentNotStiker =
              partnershipChange;
        }
        changeWicket();
        break;
    }

    // /// add run to current over
    // currentOver.add(run);
    // // currentOver = currentOver;

    // /// add total run and ball
    // totalRun = totalRun + run;
    // totalBall = totalBall + 1;

    // /// add total run and ball to current inning
    // // currentInning!.totalRun = totalRun;
    // currentInning!.totalRun = currentInning!.totalRun! + run;
    // currentInning!.totalBall = currentInning!.totalBall! + 1;

    // /// add run and ball to bowler
    // bowler!.ball = bowler!.ball! + 1;
    // bowler!.run = bowler!.run! + run;
    // bowler = bowler;

    // /// add run and ball to batsman
    // striker!.ball = striker!.ball! + 1;
    // striker!.run = striker!.run! + run;
    // if (run == 4) {
    //   striker!.four = striker!.four! + 1;
    // }
    // if (run == 6) {
    //   striker!.six = striker!.six! + 1;
    // }

    // /// add stiker and not stiker data to current inning
    // currentInning!.currentStriker = striker;
    // currentInning!.currentNonStriker = nonStriker;

    // /// add total run and ball to partnership
    // currentInning!.currentPartnerShip!.run =
    //     currentInning!.currentPartnerShip!.run! + run;
    // currentInning!.currentPartnerShip!.ball =
    //     currentInning!.currentPartnerShip!.ball! + 1;

    // /// add run and ball to partnership player
    // currentInning!.currentPartnerShip!.currentStiker!.run =
    //     currentInning!.currentPartnerShip!.currentStiker!.run! + run;
    // currentInning!.currentPartnerShip!.currentStiker!.ball =
    //     currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;

    // ///0 update current inning
    // currentInning = currentInning;

    // /// strike rotation
    // if ((run % 2 != 0 && currentOver.length != 6) ||
    //     (currentOver.length == 6 && run % 2 == 0)) {
    //   /// change striker and non striker
    //   final change = striker;
    //   striker = nonStriker;
    //   nonStriker = change;

    //   /// change partner striker and non striker in partner ship
    //   final partnershipChange =
    //       currentInning!.currentPartnerShip!.currentStiker;
    //   currentInning!.currentPartnerShip!.currentStiker =
    //       currentInning!.currentPartnerShip!.currentNotStiker;
    //   currentInning!.currentPartnerShip!.currentNotStiker = partnershipChange;
    // }
  }

  void lastSavePartnership() {
    final List<PartnerShipModel> updatedPartnerships =
        currentInning!.partnerShips!.map((e) {
      if (e.id == currentInning!.currentPartnerShip!.id) {
        return currentInning!.currentPartnerShip!;
      }
      return e;
    }).toList();
    currentInning!.partnerShips = updatedPartnerships;
  }

  void lastSave() {
    final List<BattingLineUpModel> updateBattingLineUpList =
        currentInning!.battingLineup!.map((e) {
      if (e.playerId == striker!.playerId!) {
        return striker!;
      }
      if (e.playerId == nonStriker!.playerId) {
        return nonStriker!;
      }
      return e;
    }).toList();

    final List<BowlingLineUpModel> updateBowlingLineUpList =
        currentInning!.bowlingLineup!.map((e) {
      if (e.playerId == bowler!.playerId!) {
        return bowler!;
      }
      return e;
    }).toList();

    currentInning!.battingLineup = updateBattingLineUpList;
    currentInning!.bowlingLineup = updateBowlingLineUpList;
  }

  // @action
  // void countOne() {
  //   currentOver.add(1);
  //   // currentOver = currentOver;
  //   totalRun = totalRun + 1;
  //   totalBall = totalBall + 1;
  //   // currentInning!.totalRun = totalRun;
  //   currentInning!.totalRun = currentInning!.totalRun! + 1;
  //   currentInning!.totalBall = currentInning!.totalBall! + 1;

  //   bowler!.ball = bowler!.ball! + 1;
  //   bowler!.run = bowler!.run! + 1;
  //   bowler = bowler;

  //   striker!.ball = striker!.ball! + 1;
  //   striker!.run = striker!.run! + 1;

  //   // ss
  //   final List<BattingLineUpModel> updateBattingLineUpList =
  //       currentInning!.battingLineup!.map((e) {
  //     if (e.playerId == striker!.playerId!) {
  //       return striker!;
  //     }
  //     if (e.playerId == nonStriker!.playerId) {
  //       return nonStriker!;
  //     }
  //     return e;
  //   }).toList();

  //   final List<BowlingLineUpModel> updateBowlingLineUpList =
  //       currentInning!.bowlingLineup!.map((e) {
  //     if (e.playerId == bowler!.playerId!) {
  //       return bowler!;
  //     }
  //     return e;
  //   }).toList();

  //   currentInning!.battingLineup = updateBattingLineUpList;
  //   currentInning!.bowlingLineup = updateBowlingLineUpList;

  //   currentInning!.currentPartnerShip!.run =
  //       currentInning!.currentPartnerShip!.run! + 1;

  //   currentInning!.currentPartnerShip!.ball =
  //       currentInning!.currentPartnerShip!.ball! + 1;

  //   currentInning!.currentPartnerShip!.currentStiker!.run =
  //       currentInning!.currentPartnerShip!.currentStiker!.run! + 1;
  //   currentInning!.currentPartnerShip!.currentStiker!.ball =
  //       currentInning!.currentPartnerShip!.currentStiker!.ball! + 1;
  //   currentInning!.currentPartnerShip!.currentNotStiker!.run =
  //       currentInning!.currentPartnerShip!.currentNotStiker!.run! + 1;
  //   currentInning!.currentPartnerShip!.currentNotStiker!.ball =
  //       currentInning!.currentPartnerShip!.currentNotStiker!.ball! + 1;

  //   // update current inning
  //   currentInning = currentInning;

  //   // change striker
  //   final change = striker;
  //   striker = nonStriker;
  //   nonStriker = change;

  //   final partnershipChange = currentInning!.currentPartnerShip!.currentStiker;
  //   currentInning!.currentPartnerShip!.currentStiker =
  //       currentInning!.currentPartnerShip!.currentNotStiker;
  //   currentInning!.currentPartnerShip!.currentNotStiker = partnershipChange;
  // }
}
