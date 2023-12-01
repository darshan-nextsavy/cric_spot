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

  @action
  void getAllData(String matchId) {
    matchData = matchBox.get(int.parse(matchId));
  }
}
