import 'package:cric_spot/config/routes_name.dart';
import 'package:cric_spot/core/enum/opted_type.dart';
import 'package:cric_spot/core/enum/team_type.dart';
import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_text_field.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/model/team/team_model.dart';
import 'package:cric_spot/store/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';

class NewMatchPage extends StatelessWidget {
  const NewMatchPage({super.key});

  static const List<String> suggestions = ['one', 'two', 'three'];

  @override
  Widget build(BuildContext context) {
    final homeStore = getIt.get<HomeStore>();
    homeStore.getAllData();
    TextEditingController hostTeamController = TextEditingController();
    TextEditingController visitorTeamController = TextEditingController();
    TextEditingController overController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            TypeAheadField<TeamModel>(
                hideOnEmpty: true,
                controller: hostTeamController,
                suggestionsCallback: (search) {
                  return homeStore.teams
                      .where((element) => element.name!.contains(search))
                      .toList();
                },
                onSelected: (team) {
                  homeStore.hostTeamNameChange(team.name!);
                  hostTeamController.text = team.name!;
                },
                itemBuilder: (context, team) {
                  return ListTile(
                    title: Text(team.name!),
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val) {
                      homeStore.hostTeamNameChange(val);
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "Host Team",
                    ),
                  );
                }),
            // CricTextFormField(
            //   controller: hostTeamController,
            //   hintText: "Host team",
            //   keyboardType: TextInputType.name,
            //   textCapitalization: TextCapitalization.words,
            //   onChanged: (val) {
            //     homeStore.hostTeamNameChange(val);
            //   },
            // ),
            const SizedBox(
              height: 16,
            ),
            TypeAheadField<TeamModel>(
                hideOnEmpty: true,
                controller: visitorTeamController,
                suggestionsCallback: (search) {
                  return homeStore.teams
                      .where((element) => element.name!.contains(search))
                      .toList();
                },
                onSelected: (team) {
                  homeStore.visitorTeamNameChange(team.name!);
                  visitorTeamController.text = team.name!;
                },
                itemBuilder: (context, team) {
                  return ListTile(
                    title: Text(team.name!),
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val) {
                      homeStore.visitorTeamNameChange(val);
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "Visitor Team",
                    ),
                  );
                }),
            // CricTextFormField(
            //   controller: visitorTeamController,
            //   hintText: "Visitor team",
            //   keyboardType: TextInputType.name,
            //   textCapitalization: TextCapitalization.words,
            //   onChanged: (val) {
            //     homeStore.visitorTeamNameChange(val);
            //   },
            // ),
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
                            Observer(builder: (_) {
                              return Text(homeStore.hostTeamName);
                            })
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
                            Observer(builder: (_) {
                              return Text(homeStore.visitorTeamName);
                            })
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
              "Opted to?",
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
                        homeStore.optedBy(OptedType.bat);
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Radio(
                                value: OptedType.bat,
                                groupValue: homeStore.opted,
                                onChanged: (value) {
                                  homeStore.optedBy(value);
                                }),
                            const Text("Bat")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        homeStore.optedBy(OptedType.bowl);
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Radio(
                                value: OptedType.bowl,
                                groupValue: homeStore.opted,
                                onChanged: (value) {
                                  homeStore.optedBy(value);
                                }),
                            const Text("Bowl")
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
              onChanged: (val) {
                homeStore.over = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .push(RoutesName.adwanceSetting.path);
                      },
                      child: const Text("Adwance Setting")),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: FilledButton(
                        onPressed: () {
                          homeStore.isMatchNew = true;
                          // GoRouter.of(context).push(RoutesName.scoreCount.path);
                          GoRouter.of(context)
                              .push(RoutesName.playerSelect.path);
                        },
                        child: const Text("Start Match")))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
