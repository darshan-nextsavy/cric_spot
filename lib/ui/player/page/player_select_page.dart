import 'package:cric_spot/config/routes_name.dart';
import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_text_field.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayerSelectPage extends StatelessWidget {
  const PlayerSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = getIt.get<HomeStore>();

    TextEditingController strikerController = TextEditingController();
    TextEditingController nonStrikerController = TextEditingController();
    TextEditingController bowlerController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select opening players'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "Striker",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: strikerController,
              hintText: "Player name",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                homeStore.strikerName = val;
                // homeStore.hostTeamNameChange(val);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Non-Striker",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: nonStrikerController,
              hintText: "Player name",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                homeStore.nonStrikerName = val;
                // homeStore.visitorTeamNameChange(val);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Opening Bowler",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: bowlerController,
              hintText: "Player name",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                homeStore.openingBowlerName = val;
                // homeStore.visitorTeamNameChange(val);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
                onPressed: () async {
                  final matchId = await homeStore.createNewMatch();
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pushNamed(RoutesName.scoreCount.name,
                      pathParameters: {'matchId': matchId.toString()});
                },
                child: const Text("Start Match"))
          ],
        ),
      ),
    );
  }
}
