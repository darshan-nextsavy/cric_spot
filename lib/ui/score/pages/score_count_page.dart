// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_card.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/score/score_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
    // TODO: implement initState
    super.initState();
    scoreStore.getAllData(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.matchId);
    // print(scoreStore.currentOver);
    // print(scoreStore.striker);
    // print(scoreStore.nonStriker);
    // print(scoreStore.bowler);

    return Observer(builder: (_) {
      print(scoreStore.currentInning?.totalRun);
      return scoreStore.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                    '${scoreStore.matchData?.firstBatTeamName} vs ${scoreStore.matchData?.secondBatTeamName}'),
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
                                              : ((scoreStore.striker!.run!) /
                                                      (scoreStore
                                                              .striker!.ball! *
                                                          100))
                                                  .toString()),
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
                                              : ((scoreStore.nonStriker!.run!) /
                                                      (scoreStore.nonStriker!
                                                              .ball! *
                                                          100))
                                                  .toString()),
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
                                                      scoreStore.bowler!.ball!)
                                                  .toString()),
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
                                            .map(((e) => CricOutlineCard(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: context.outline,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child:
                                                      Center(child: Text("2")),
                                                ))))
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
                              InkWell(
                                onTap: () {
                                  scoreStore.changeWide();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Observer(builder: (_) {
                                        return Checkbox(
                                          value: scoreStore.wide,
                                          onChanged: (val) {
                                            scoreStore.changeWide();
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }),
                                    ),
                                    Text("Wide")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  scoreStore.changeNoball();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Observer(builder: (context) {
                                        return Checkbox(
                                          value: scoreStore.noBall,
                                          onChanged: (val) {
                                            scoreStore.changeNoball();
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }),
                                    ),
                                    Text("No Ball")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  scoreStore.changeByes();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Observer(builder: (_) {
                                        return Checkbox(
                                          value: scoreStore.byes,
                                          onChanged: (val) {
                                            scoreStore.changeByes();
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }),
                                    ),
                                    Text("Byes")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  scoreStore.changeLegbyes();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Observer(builder: (_) {
                                        return Checkbox(
                                          value: scoreStore.legByes,
                                          onChanged: (val) {
                                            scoreStore.changeLegbyes();
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }),
                                    ),
                                    Text("Leg Byes")
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  scoreStore.wicket = !scoreStore.wicket;
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Observer(builder: (_) {
                                        return Checkbox(
                                          value: scoreStore.wicket,
                                          onChanged: (val) {
                                            scoreStore.wicket = val!;
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }),
                                    ),
                                    Text("Wicket")
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: context.primary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Retire",
                                          style: TextStyle(
                                              color: context.onPrimary),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: 120,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: context.primary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Swap Batsman",
                                          style: TextStyle(
                                              color: context.onPrimary),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                InkWell(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: context.primary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Undo",
                                        style:
                                            TextStyle(color: context.onPrimary),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: context.primary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Partnerships",
                                        style:
                                            TextStyle(color: context.onPrimary),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: context.primary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Extra",
                                        style:
                                            TextStyle(color: context.onPrimary),
                                      ),
                                    ),
                                  ),
                                ),
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
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("0")),
                                        )),
                                    InkWell(
                                      onTap: () {
                                        scoreStore.countOne();
                                      },
                                      child: CricOutlineCard(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            side: BorderSide(
                                              width: 1,
                                              color: context.outline,
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Center(child: Text("1")),
                                          )),
                                    ),
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("2")),
                                        )),
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("3")),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("4")),
                                        )),
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("5")),
                                        )),
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("6")),
                                        )),
                                    CricOutlineCard(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                            width: 1,
                                            color: context.outline,
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Center(child: Text("...")),
                                        )),
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

  Widget buildTableRow(List<String> rowData, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      color:
          isHeader ? Colors.grey[300] : null, // Change header color if needed
      child: Row(
        children: rowData.map((data) {
          return Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
