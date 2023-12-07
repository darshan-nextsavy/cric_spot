// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cric_spot/config/routes_name.dart';
import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_card.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/score/score_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class ScoreCountPage extends StatefulWidget {
  final String matchId;
  const ScoreCountPage({super.key, required this.matchId});

  @override
  State<ScoreCountPage> createState() => _ScoreCountPageState();
}

class _ScoreCountPageState extends State<ScoreCountPage> {
  final ScoreStore scoreStore = getIt.get<ScoreStore>();

  @override
  void initState() {
    super.initState();
    scoreStore.getAllData(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return scoreStore.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                    '${scoreStore.matchData?.firstBatTeamName} vs ${scoreStore.matchData?.secondBatTeamName}'),
                actions: [
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                            RoutesName.scoreBoard.name,
                            pathParameters: {"matchId": widget.matchId});
                      },
                      icon: Icon(Icons.scoreboard)),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ListView(
                  children: [
                    // 1 : main score card
                    CricCard(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "${scoreStore.currentInning?.batTeamName}, ${scoreStore.currentInning!.isFirstInning! ? '1st' : '2nd'} Inning")),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: scoreStore
                                              .currentInning!.isFirstInning!
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Crr"),
                                        Observer(builder: (_) {
                                          return scoreStore
                                                  .currentInning!.isFirstInning!
                                              ? SizedBox.shrink()
                                              : Text("Target");
                                        }),
                                        Observer(builder: (_) {
                                          return scoreStore
                                                  .currentInning!.isFirstInning!
                                              ? SizedBox.shrink()
                                              : Text("RR");
                                        }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Observer(builder: (_) {
                                        return Text(
                                          // "${scoreStore.currentInning?.totalRun} - ${scoreStore.currentInning?.totalWicket}",
                                          "${scoreStore.totalRun} - ${scoreStore.currentInning?.totalWicket}",
                                          style: context.headlineLarge
                                              ?.copyWith(
                                                  color: context
                                                      .onPrimaryContainer),
                                        );
                                      }),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        children: [
                                          Observer(builder: (_) {
                                            return Text(
                                              // "(${scoreStore.currentInning!.totalBall! ~/ 6}.${scoreStore.currentInning!.totalBall! % 6})",
                                              "(${scoreStore.totalBall ~/ 6}.${scoreStore.totalBall % 6})",
                                              style: context.headlineSmall
                                                  ?.copyWith(
                                                      color: context
                                                          .onSurfaceVariant),
                                            );
                                          }),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: scoreStore
                                              .currentInning!.isFirstInning!
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceAround,
                                      children: [
                                        Text((scoreStore.totalRun /
                                                (scoreStore.totalBall / 6))
                                            .toStringAsFixed(2)),
                                        Observer(builder: (_) {
                                          return scoreStore
                                                  .currentInning!.isFirstInning!
                                              ? SizedBox.shrink()
                                              : Text(
                                                  scoreStore.target.toString());
                                        }),
                                        Observer(builder: (_) {
                                          return scoreStore
                                                  .currentInning!.isFirstInning!
                                              ? SizedBox.shrink()
                                              : Text("8.36");
                                        }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              scoreStore.currentInning!.isFirstInning!
                                  ? SizedBox.shrink()
                                  : Text(
                                      "${scoreStore.matchData?.secondBatTeamName} need 125 runs in 75 balls",
                                      style: context.bodyLarge?.copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500),
                                    )
                            ],
                          ),
                        )),
                    // 2 : batsman score card
                    CricCard(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text("Batsman")),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("R"),
                                        Text("B"),
                                        Text("4s"),
                                        Text("6s"),
                                        Text("SR"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Observer(builder: (_) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                            scoreStore.striker?.name ?? '')),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(scoreStore.striker?.run
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.striker?.ball
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.striker?.four
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.striker?.six
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.striker!.ball == 0
                                              ? "0.00"
                                              : ((scoreStore.striker!.run! *
                                                          100) /
                                                      (scoreStore
                                                          .striker!.ball!))
                                                  .toStringAsFixed(1)),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 6,
                              ),
                              Observer(builder: (_) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                            scoreStore.nonStriker?.name ?? '')),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(scoreStore.nonStriker?.run
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.nonStriker?.ball
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.nonStriker?.four
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.nonStriker?.six
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.nonStriker!.ball == 0
                                              ? "0.00"
                                              : ((scoreStore.nonStriker!.run! *
                                                          100) /
                                                      (scoreStore
                                                          .nonStriker!.ball!))
                                                  .toStringAsFixed(1)),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text("Bowler")),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("O"),
                                        Text("M"),
                                        Text("R"),
                                        Text("W"),
                                        Text("ER"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Observer(builder: (_) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                            scoreStore.bowler?.name ?? '')),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              "${scoreStore.bowler!.ball! ~/ 6}.${scoreStore.currentInning!.totalBall! % 6}"),
                                          Text(scoreStore.bowler?.maidan
                                                  .toString() ??
                                              '0'),
                                          Text(scoreStore.bowler?.run
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.bowler?.wicket
                                                  .toString() ??
                                              ''),
                                          Text(scoreStore.bowler!.ball == 0
                                              ? '0.0'
                                              : (scoreStore.bowler!.run! /
                                                      (scoreStore
                                                              .bowler!.ball! /
                                                          6))
                                                  .toStringAsFixed(1)),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ],
                          ),
                        )),
                    // 3 : current over
                    CricCard(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("This Over: "),
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: Observer(builder: (_) {
                                    return ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...scoreStore.currentOver
                                            .map(
                                                ((e) => overCircleCard(run: e)))
                                            .toList()
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        )),
                    // 4 : extra
                    CricCard(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              checkBoxWidget(
                                  childText: "Wide", value: scoreStore.wide),
                              checkBoxWidget(
                                  childText: "No Ball",
                                  value: scoreStore.noBall),
                              checkBoxWidget(
                                  childText: "Byes", value: scoreStore.byes),
                              checkBoxWidget(
                                  childText: "Leg Byes",
                                  value: scoreStore.legByes),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              checkBoxWidget(
                                  childText: "Wicket",
                                  value: scoreStore.wicket),
                              Row(
                                children: [
                                  cricFilledButton(
                                      childText: "Retire", width: 120),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  cricFilledButton(
                                      childText: "Swap Batsman", width: 120),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                    // 5 : run count
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: CricCard(
                              child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                cricFilledButton(childText: "Undo"),
                                const SizedBox(
                                  height: 4,
                                ),
                                cricFilledButton(childText: "Partnerships"),
                                const SizedBox(
                                  height: 4,
                                ),
                                cricFilledButton(childText: "Extra")
                              ],
                            ),
                          )),
                        ),
                        Expanded(
                          child: CricCard(
                              child: Container(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    countRunCard(
                                        child: "0",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.wicket
                                                ? GoRouter.of(context)
                                                    .pushNamed(
                                                        RoutesName
                                                            .fallOfWicket.name,
                                                        pathParameters: {
                                                        "run": "0"
                                                      })
                                                : scoreStore.countRun(run: 0);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(
                                        child: "1",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.wicket
                                                ? GoRouter.of(context)
                                                    .pushNamed(
                                                        RoutesName
                                                            .fallOfWicket.name,
                                                        pathParameters: {
                                                        "run": "1"
                                                      })
                                                : scoreStore.countRun(run: 1);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(
                                        child: "2",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.countRun(run: 2);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(
                                        child: "3",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.countRun(run: 3);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    countRunCard(
                                        child: "4",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.countRun(run: 4);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(
                                        child: "5",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.countRun(run: 5);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(
                                        child: "6",
                                        onTap: () {
                                          if (scoreStore.overLength < 6) {
                                            scoreStore.countRun(run: 6);
                                            if (scoreStore.overLength == 6) {
                                              GoRouter.of(context).push(
                                                  RoutesName.selectBowler.path);
                                            }
                                          } else {
                                            GoRouter.of(context).push(
                                                RoutesName.selectBowler.path);
                                          }
                                        }),
                                    countRunCard(child: "...", onTap: () {}),
                                  ],
                                )
                              ],
                            ),
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
    });
  }

  Widget countRunCard({required String child, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: CricOutlineCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              width: 1,
              color: context.outline,
            ),
          ),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Center(child: Text(child)),
          )),
    );
  }

  Widget checkBoxWidget({
    required String childText,
    required bool value,
  }) {
    return InkWell(
      onTap: () {
        switch (childText) {
          case "Wicket":
            scoreStore.changeWicket();
            break;
          case "Wide":
            scoreStore.changeWide();
            break;
          case "No Ball":
            scoreStore.changeNoball();
            break;
          case "Byes":
            scoreStore.changeByes();
            break;
          case "Leg Byes":
            scoreStore.changeLegbyes();
            break;
        }
      },
      child: Row(
        children: [
          SizedBox(
            child: Checkbox(
              value: value,
              onChanged: (val) {
                switch (childText) {
                  case "Wicket":
                    scoreStore.changeWicket();
                    break;
                  case "Wide":
                    scoreStore.changeWide();
                    break;
                  case "No Ball":
                    scoreStore.changeNoball();
                    break;
                  case "Byes":
                    scoreStore.changeByes();
                    break;
                  case "Leg Byes":
                    scoreStore.changeLegbyes();
                    break;
                }
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Text(childText)
        ],
      ),
    );
  }

  Widget cricFilledButton(
      {required String childText, double? width, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
            color: context.primary, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            childText,
            style: TextStyle(color: context.onPrimary),
          ),
        ),
      ),
    );
  }

  Widget overCircleCard({required int run}) {
    return CricOutlineCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 1,
            color: context.outline,
          ),
        ),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(child: Text(run.toString())),
        ));
  }
}
