enum RoutesName {
  login,
  landing,
  newMatch,
  teams,
  history,
  scoreCount,
  adwanceSetting,
  setting,
  selectBowler,
  playerSelect;
}

extension RoutesNameHelper on RoutesName {
  String get name {
    switch (this) {
      case RoutesName.login:
        return 'login';
      case RoutesName.landing:
        return 'landing';
      case RoutesName.newMatch:
        return 'new-match';
      case RoutesName.teams:
        return 'teams';
      case RoutesName.history:
        return 'history';
      case RoutesName.adwanceSetting:
        return 'adwance-setting';
      case RoutesName.setting:
        return 'setting';
      case RoutesName.scoreCount:
        return 'score-count';
      case RoutesName.playerSelect:
        return 'player-select';
      case RoutesName.selectBowler:
        return 'select-bowler';
    }
  }

  String get path {
    switch (this) {
      case RoutesName.login:
        return '/login';
      case RoutesName.landing:
        return '/landing';
      case RoutesName.newMatch:
        return '/new-match';
      case RoutesName.teams:
        return '/teams';
      case RoutesName.history:
        return '/history';
      case RoutesName.adwanceSetting:
        return '/adwance-setting';
      case RoutesName.setting:
        return '/setting';
      case RoutesName.scoreCount:
        return '/score-count/:matchId';
      case RoutesName.playerSelect:
        return '/player-select';
      case RoutesName.selectBowler:
        return '/select-bowler';
    }
  }
}
