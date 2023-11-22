import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Image.network(
                            "https://d1muf25xaso8hp.cloudfront.net/https%3A%2F%2Fmeta-q.cdn.bubble.io%2Ff1512936020165x278911292087286720%2FA.png?w=&h=&auto=compress&dpr=1&fit=max"),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Team A",
                              style: context.titleMedium,
                            ),
                            Text(
                              "Match: 1000",
                              style: context.bodySmall,
                            ),
                            Text(
                              "Won: 700  Loss: 300",
                              style: context.bodySmall,
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
