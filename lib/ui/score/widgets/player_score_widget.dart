import 'package:flutter/material.dart';

Widget batsmanScoreWidget({
  String? batsmanName,
  int? run,
  int? ball,
  int? four,
  int? six,
  required BuildContext context,
}) {
  return Row(
    children: [
      Expanded(child: Text(batsmanName ?? "Batsman")),
      Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${run ?? 'R'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${ball ?? 'B'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${four ?? '4s'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${six ?? '6s'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            child: Text(
              ball == null
                  ? 'SR'
                  : ball == 0
                      ? "0.00"
                      : ((run! * 100) / ball).toStringAsFixed(2),
              textAlign: TextAlign.end,
            ),
          )
        ],
      )
    ],
  );
}

Widget bowlerScoreWidget({
  String? bowlerName,
  int? ball,
  int? maidan,
  int? run,
  int? wicket,
  required BuildContext context,
}) {
  return Row(
    children: [
      Expanded(child: Text(bowlerName ?? "Bowler")),
      Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${ball == null ? 'O' : (ball ~/ 6)}.${(ball! % 6)}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${maidan ?? 'M'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${run ?? 'R'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            child: Text(
              "${wicket ?? 'W'}",
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            child: Text(
              ball == null
                  ? 'ER'
                  : ball == 0
                      ? "0.00"
                      : (run! / (ball / 6)).toStringAsFixed(1),
              textAlign: TextAlign.end,
            ),
          )
        ],
      )
    ],
  );
}
