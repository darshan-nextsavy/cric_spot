import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_card.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = getIt.get<HomeStore>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Observer(builder: (_) {
          return ListView.builder(
              itemCount: homeStore.getMatchHistory().length,
              itemBuilder: (context, index) {
                return matchHistoryCard(context);
              });
        }),
      ),
    );
  }

  Widget matchHistoryCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "23/01/2023 - 02:45 PM",
              style: context.bodyMedium,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: Image.network(
                          "https://d1muf25xaso8hp.cloudfront.net/https%3A%2F%2Fmeta-q.cdn.bubble.io%2Ff1512936020165x278911292087286720%2FA.png?w=&h=&auto=compress&dpr=1&fit=max"),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "team name",
                      style: context.titleMedium,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "14/5",
                      style: context.titleLarge,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text("(0.0)"),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: Image.network(
                          "https://d1muf25xaso8hp.cloudfront.net/https%3A%2F%2Fmeta-q.cdn.bubble.io%2Ff1512936020165x278911292087286720%2FA.png?w=&h=&auto=compress&dpr=1&fit=max"),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "team name",
                      style: context.titleMedium,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "14/5",
                      style: context.titleLarge,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text("(0.0)"),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Team A obted Bat first",
              style: context.bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: () {}, child: const Text("Resume")),
                      TextButton(
                          onPressed: () {}, child: const Text("Score Card")),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
