import 'package:cric_spot/core/enum/wicket_type.dart';
import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_text_field.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/model/batting/batting_lineup_model.dart';
import 'package:cric_spot/store/score/score_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class FallOfWicketPage extends StatelessWidget {
  final String run;
  const FallOfWicketPage({super.key, required this.run});

  @override
  Widget build(BuildContext context) {
    final scoreStore = getIt.get<ScoreStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fall of wicket"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "How Wicket Fall?",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.onSecondaryContainer),
                color: context.surfaceVariant,
              ),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: Observer(builder: (context) {
                  return DropdownButton(
                    borderRadius: BorderRadius.circular(12.0),
                    onChanged: (val) {
                      scoreStore.wicketType = val!;
                    },
                    value: scoreStore.wicketType,
                    items: WicketType.values.map((e) {
                      return DropdownMenuItem<WicketType>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       DropdownMenu(
            //           enableSearch: true,
            //           initialSelection: WicketType.bowled,
            //           inputDecorationTheme: InputDecorationTheme(
            //               isCollapsed: false,
            //               border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(12.0)),
            //               filled: true),
            //           dropdownMenuEntries: WicketType.values.map((e) {
            //             return DropdownMenuEntry<WicketType>(
            //               value: e,
            //               label: e.name,
            //             );
            //           }).toList()),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "New Batsman",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            scoreStore.totalWicket ==
                    (int.parse(scoreStore.matchData!.playerPerMatch!) - 2)
                ? const SizedBox.shrink()
                : CricTextFormField(
                    // controller: strikerController,
                    hintText: "Player name",
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val) {
                      scoreStore.newBatsman = val;
                    },
                  ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: Observer(builder: (_) {
                return FilledButton(
                    onPressed: scoreStore.newBatsman == ''
                        ? null
                        : () async {
                            final newPlayer = await scoreStore.fallOfWicket();
                            final newPlayerBat = BattingLineUpModel(
                                playerId: newPlayer.id,
                                name: newPlayer.name,
                                run: 0,
                                ball: 0,
                                four: 0,
                                six: 0,
                                isNotOut: true);
                            scoreStore.countRun(
                                run: int.parse(run), newPlayer: newPlayerBat);
                            if (!context.mounted) return;
                            GoRouter.of(context).pop();
                          },
                    child: const Text("Done"));
              }),
            )
          ],
        ),
      ),
    );
  }
}
