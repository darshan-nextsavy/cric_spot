import 'package:cric_spot/core/extensions/color_extension.dart';
import 'package:cric_spot/core/extensions/text_style_extensions.dart';
import 'package:cric_spot/core/widgtes/cric_widgets/cric_text_field.dart';
import 'package:cric_spot/main.dart';
import 'package:cric_spot/store/score/score_store.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectBowlerPage extends StatelessWidget {
  const SelectBowlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreStore = getIt.get<ScoreStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Bowler'),
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
              "Select a new bowler",
              style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: context.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            CricTextFormField(
              // controller: strikerController,
              hintText: "Player name",
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                scoreStore.newBowler = val;
                // homeStore.strikerName = val;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async {
                    await scoreStore.selectNewBowler();
                    GoRouter.of(context).pop();
                  },
                  child: const Text("Done")),
            )
          ],
        ),
      ),
    );
  }
}
