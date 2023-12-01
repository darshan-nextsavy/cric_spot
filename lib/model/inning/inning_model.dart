import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'inning_model.freezed.dart';
part 'inning_model.g.dart';

@unfreezed
class InningModel extends HiveObject with _$InningModel {
  @HiveType(typeId: 3, adapterName: 'InningModelAdapter')
  factory InningModel({
    @HiveField(0) String? id,
    @HiveField(1) String? matchId,
    @HiveField(2) String? batTeamName,
    @HiveField(3) String? bowlTeamName,
    @HiveField(4) int? totalRun,
    @HiveField(5) int? totalWicket,
    @HiveField(6) int? totalBall,
    @HiveField(7) List<BattingLineUp>? battingLineup,
    @HiveField(8) List<BowlingLineUp>? bowlingLineup,
    @HiveField(9) ExtraRun? extraRun,
    @HiveField(10) BowlingLineUp? currentBowler,
    @HiveField(11) BattingLineUp? currentStriker,
    @HiveField(12) BattingLineUp? currentNonStriker,
    @HiveField(13) List<List<int>>? overs,
    @HiveField(14) List<int>? currentOver,
    @HiveField(15) List<PartnerShip>? partnerShips,
    @HiveField(16) PartnerShip? currentPartnerShip,
    @HiveField(17) bool? isFirstInning,
  }) = _InningModel;
  InningModel._();

  factory InningModel.fromJson(Map<String, dynamic> json) =>
      _$InningModelFromJson(json)
        ..battingLineup = (json['battingLineup'] as List<dynamic>?)
            ?.map((e) => BattingLineUp.fromJson(e as Map<String, dynamic>))
            .toList()
        ..bowlingLineup = (json['bowlingLineup'] as List<dynamic>?)
            ?.map((e) => BowlingLineUp.fromJson(e as Map<String, dynamic>))
            .toList()
        ..extraRun = json['extraRun'] != null
            ? ExtraRun.fromJson(json['extraRun'] as Map<String, dynamic>)
            : null
        ..partnerShips = (json['partnerShips'] as List<dynamic>?)
            ?.map((e) => PartnerShip.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batTeamName': batTeamName,
      'bowlTeamName': bowlTeamName,
      'totalRun': totalRun,
      'totalWicket': totalWicket,
      'totalBall': totalBall,
      'battingLineup': battingLineup?.map((e) => e.toJson()).toList(),
      'bowlingLineup': bowlingLineup?.map((e) => e.toJson()).toList(),
      'extraRun': extraRun?.toJson(),
      'currentBowler': currentBowler?.toJson(),
      'currentStriker': currentStriker?.toJson(),
      'currentNonStriker': currentNonStriker?.toJson(),
      'overs': overs,
      'currentOver': currentOver,
      'partnerShips': partnerShips?.map((e) => e.toJson()).toList(),
      'currentPartnerShip': currentPartnerShip?.toJson(),
    };
  }
}

class BattingLineUp {
  String? playerId;
  String? name;
  int? run;
  int? ball;
  int? four;
  int? six;
  bool? isNotOut;
  String? outBy;
  String? outType;
  BattingLineUp(
      {this.playerId,
      this.name,
      this.run,
      this.ball,
      this.four,
      this.isNotOut,
      this.outBy,
      this.outType,
      this.six});

  factory BattingLineUp.fromJson(Map<String, dynamic> json) {
    return BattingLineUp(
      playerId: json['playerId'] as String?,
      name: json['name'] as String?,
      run: json['run'] as int?,
      ball: json['ball'] as int?,
      four: json['four'] as int?,
      six: json['six'] as int?,
      isNotOut: json['isNotOut'] as bool?,
      outBy: json['outBy'] as String?,
      outType: json['outType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'name': name,
      'run': run,
      'ball': ball,
      'four': four,
      'six': six,
      'isNotOut': isNotOut,
      'outBy': outBy,
      'outType': outType,
    };
  }
}

class BowlingLineUp {
  String? playerId;
  String? name;
  int? run;
  int? ball;
  int? wicket;
  int? maidan;
  BowlingLineUp(
      {this.playerId,
      this.name,
      this.run,
      this.ball,
      this.maidan,
      this.wicket});

  factory BowlingLineUp.fromJson(Map<String, dynamic> json) {
    return BowlingLineUp(
      playerId: json['playerId'] as String?,
      name: json['name'] as String?,
      run: json['run'] as int?,
      ball: json['ball'] as int?,
      wicket: json['wicket'] as int?,
      maidan: json['maidan'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'name': name,
      'run': run,
      'ball': ball,
      'wicket': wicket,
      'maidan': maidan,
    };
  }
}

class ExtraRun {
  int? wide;
  int? noBall;
  int? legBy;
  int? by;
  int? penlaty;
  int? total;

  ExtraRun(
      {this.wide, this.noBall, this.legBy, this.by, this.penlaty, this.total});

  factory ExtraRun.fromJson(Map<String, dynamic> json) {
    return ExtraRun(
      wide: json['wide'] as int?,
      noBall: json['noBall'] as int?,
      legBy: json['legBy'] as int?,
      by: json['by'] as int?,
      penlaty: json['penlaty'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wide': wide,
      'noBall': noBall,
      'legBy': legBy,
      'by': by,
      'penlaty': penlaty,
      'total': total,
    };
  }
}

class PartnerShip {
  int? run;
  int? ball;
  int? extra;
  BattingLineUp? currentStiker;
  BattingLineUp? currentNotStiker;
  PartnerShip(
      {this.run,
      this.ball,
      this.extra,
      this.currentStiker,
      this.currentNotStiker});

  factory PartnerShip.fromJson(Map<String, dynamic> json) {
    return PartnerShip(
      run: json['run'] as int?,
      ball: json['ball'] as int?,
      extra: json['extra'] as int?,
      currentStiker: BattingLineUp.fromJson(
        json['currentStiker'] as Map<String, dynamic>,
      ),
      currentNotStiker: BattingLineUp.fromJson(
        json['currentNotStiker'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'run': run,
      'ball': ball,
      'extra': extra,
      'currentStiker': currentStiker?.toJson(),
      'currentNotStiker': currentNotStiker?.toJson(),
    };
  }
}
