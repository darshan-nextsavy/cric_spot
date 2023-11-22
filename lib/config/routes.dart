import 'package:cric_spot/config/routes_name.dart';
import 'package:cric_spot/ui/home/pages/home/home_page.dart';
import 'package:cric_spot/ui/settings/pages/adwance-setting/adwance_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
    initialLocation: RoutesName.landing.path,
    observers: <NavigatorObserver>[
      HeroController()
    ],
    routes: [
      GoRoute(
          path: RoutesName.landing.path,
          name: RoutesName.landing.name,
          builder: (context, state) => const HomePage()),
      GoRoute(
          path: RoutesName.adwanceSetting.path,
          name: RoutesName.adwanceSetting.name,
          builder: (context, state) => const AdwanceSettingPage()),
    ]);
