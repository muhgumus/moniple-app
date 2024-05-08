import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monipleapp/stores/config_store.dart';
import 'package:monipleapp/stores/pod_store.dart';
import 'package:monipleapp/stores/pvc_store.dart';
import 'package:provider/provider.dart';

import 'package:monipleapp/constants.dart';
import 'package:monipleapp/controllers/menu_app_controller.dart';
import 'package:monipleapp/screens/main/main_screen.dart';
import 'package:monipleapp/stores/main_store.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MainStore>(create: (_) => MainStore()),
    ChangeNotifierProvider<PodStore>(create: (_) => PodStore()),
    ChangeNotifierProvider<PvcStore>(create: (_) => PvcStore()),
    ChangeNotifierProvider<ConfigStore>(create: (_) => ConfigStore()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        cardColor: Colors.amber,
        dividerColor: Colors.red,
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
