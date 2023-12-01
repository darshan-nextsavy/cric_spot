// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_card.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/score/score_store.dart';
import 'package:flutter/material.dart';

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
    print(widget.matchId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeamA vs TeamB'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
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
                      const Row(
                        children: [
                          Expanded(child: Text("TeamA, 2nd Inning")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Crr"),
                                Text("Target"),
                                Text("RR")
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
                              Text(
                                "0 - 0",
                                style: context.headlineLarge?.copyWith(
                                    color: context.onPrimaryContainer),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "(0.0)",
                                    style: context.headlineSmall?.copyWith(
                                        color: context.onSurfaceVariant),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ],
                              )
                            ],
                          )),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("0.0"),
                                Text("125"),
                                Text("9.56")
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "TeamB need 125 runs in 75 balls",
                        style: context.bodyLarge?.copyWith(
                            color: Colors.green, fontWeight: FontWeight.w500),
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
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Batsman")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Batsman")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("120"),
                                Text("10"),
                                Text("0"),
                                Text("0"),
                                Text("0.00"),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Batsman")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("120"),
                                Text("0"),
                                Text("120"),
                                Text("0"),
                                Text("0.00"),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Bowler")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Bowler")),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("0"),
                                Text("0"),
                                Text("0"),
                                Text("0"),
                                Text("0.00"),
                              ],
                            ),
                          )
                        ],
                      ),
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
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...[
                                1,
                                2,
                                3,
                                4,
                                4,
                                4,
                                4,
                              ]
                                  .map(((e) => CricOutlineCard(
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
                                        child: Center(child: Text("2")),
                                      ))))
                                  .toList()
                            ],
                          ),
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
                        child: Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                value: true,
                                onChanged: (val) {},
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            Text("Wide")
                          ],
                        ),
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                value: true,
                                onChanged: (val) {},
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            Text("No Ball")
                          ],
                        ),
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                value: true,
                                onChanged: (val) {},
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            Text("Byes")
                          ],
                        ),
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                value: true,
                                onChanged: (val) {},
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
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
                        child: Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                value: true,
                                onChanged: (val) {},
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            Text("Leg Byes")
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Retire",
                                  style: TextStyle(color: context.onPrimary),
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Swap Batsman",
                                  style: TextStyle(color: context.onPrimary),
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Undo",
                                style: TextStyle(color: context.onPrimary),
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Partnerships",
                                style: TextStyle(color: context.onPrimary),
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Extra",
                                style: TextStyle(color: context.onPrimary),
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
                                  borderRadius: BorderRadius.circular(25),
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
                            CricOutlineCard(
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
                                  child: Center(child: Text("1")),
                                )),
                            CricOutlineCard(
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
                                  child: Center(child: Text("2")),
                                )),
                            CricOutlineCard(
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
                                  child: Center(child: Text("3")),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            CricOutlineCard(
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
                                  child: Center(child: Text("4")),
                                )),
                            CricOutlineCard(
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
                                  child: Center(child: Text("5")),
                                )),
                            CricOutlineCard(
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
                                  child: Center(child: Text("6")),
                                )),
                            CricOutlineCard(
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
