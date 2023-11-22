enum RoutesName {
  login,
  landing,
  newMatch,
  teams,
  history,
  adwanceSetting,
  setting;
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
    }
  }
}
