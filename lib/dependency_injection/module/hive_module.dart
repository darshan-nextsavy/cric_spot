import 'package:cric_spot/model/inning/inning_model.dart';
import 'package:cric_spot/model/match/match_model.dart';
import 'package:cric_spot/model/player/player_model.dart';
import 'package:cric_spot/model/team/team_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveAdapter {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(TeamModelAdapter())
      ..registerAdapter(PlayerModelAdapter())
      ..registerAdapter(MatchModelAdapter())
      ..registerAdapter(InningModelAdapter());
  }
}
