import 'package:cric_spot/config/routes.dart';
import 'package:cric_spot/core/theme/app_theme.dart';
import 'package:cric_spot/store/home/home_store.dart';
import 'package:cric_spot/ui/home/pages/home/home_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (_) => HomeStore()),
        ],
        builder: (context, child) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            final bool isDynamic = false;
            final ThemeMode themeMode = ThemeMode.values[0];
            final int color = 0xFF795548;
            final Color primaryColor = Color(color);

            final String fontPreference = 'Outfit';
            final TextTheme darkTextTheme = GoogleFonts.getTextTheme(
              fontPreference,
              ThemeData.dark().textTheme,
            );
            final TextTheme lightTextTheme = GoogleFonts.getTextTheme(
              fontPreference,
              ThemeData.light().textTheme,
            );

            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            if (lightDynamic != null && darkDynamic != null) {
              lightColorScheme = lightDynamic.harmonized();
              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(
                seedColor: primaryColor,
              );
              darkColorScheme = ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.dark,
              );
            }

            return MaterialApp.router(
              title: 'Flutter Demo',
              routerConfig: goRouter,
              debugShowCheckedModeBanner: false,
              theme: appTheme(
                  context,
                  lightColorScheme,
                  fontPreference,
                  lightTextTheme,
                  ThemeData.light().dividerColor,
                  SystemUiOverlayStyle.dark),
              darkTheme: appTheme(
                  context,
                  darkColorScheme,
                  fontPreference,
                  darkTextTheme,
                  ThemeData.dark().dividerColor,
                  SystemUiOverlayStyle.light),
              // theme: ThemeData(
              //   colorScheme:
              //       lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.pink),
              //   useMaterial3: true,
              // ),
              // darkTheme: ThemeData(
              //     colorScheme: darkDynamic ??
              //         ColorScheme.fromSeed(
              //             seedColor: Colors.pink, brightness: Brightness.dark),
              //     useMaterial3: true),
            );
          });
        });
  }
}
