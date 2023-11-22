import 'package:cric_spot/core/enum/team_type.dart';
import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_text_field.dart';
import 'package:cric_spot/store/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NewMatchPage extends StatelessWidget {
  const NewMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = Provider.of<HomeStore>(context);
    TextEditingController hostTeamController = TextEditingController();
    TextEditingController visitorTeamController = TextEditingController();
    TextEditingController overController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              "Teams",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: hostTeamController,
              hintText: "Host team",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: visitorTeamController,
              hintText: "Visitor team",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Toss won by?",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Observer(builder: (_) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        homeStore.tossWon(TeamType.host);
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Radio(
                                value: TeamType.host,
                                groupValue: homeStore.tossWonBy,
                                onChanged: (value) {
                                  homeStore.tossWon(value);
                                }),
                            const Text('Host Team')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        homeStore.tossWon(TeamType.visitor);
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Radio(
                                value: TeamType.visitor,
                                groupValue: homeStore.tossWonBy,
                                onChanged: (value) {
                                  homeStore.tossWon(value);
                                }),
                            const Text('Visitor Team')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Overs?",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              controller: overController,
              hintText: "Overs",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Adwance Setting")),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: FilledButton(
                        onPressed: () {}, child: const Text("Start Match")))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
