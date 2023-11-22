import 'package:cric_spot/core/enum/team_type.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int selectedIndex = 0;

  @observable
  bool noBallReBall = true;

  @observable
  bool wideReBall = true;

  @observable
  TeamType tossWonBy = TeamType.host;

  @action
  void currentIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
    }
  }

  @action
  void tossWon(value) {
    if (value != tossWonBy) {
      tossWonBy = value;
    }
  }

  @action
  void noBallReBallSwitch(bool value) {
    if (noBallReBall != value) {
      noBallReBall = value;
    }
  }

  @action
  void wideBallReBallSwitch(value) {
    if (wideReBall != value) {
      wideReBall = value;
    }
  }
}
