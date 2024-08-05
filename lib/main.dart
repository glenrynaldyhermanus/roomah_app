import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomah/routes.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Roomah',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: RoomahColors.primary),
        scaffoldBackgroundColor: RoomahColors.backgroundPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: RoomahColors.primaryAccent,
          foregroundColor: RoomahColors.textSecondary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: RoomahColors.textSecondary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: RoomahColors.secondary,
            foregroundColor: RoomahColors.textSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: RoomahColors.secondary,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: RoomahColors.secondary,
            elevation: 0,
            shape: CircleBorder(),
            foregroundColor: RoomahColors.iconButtonPrimary),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            side: const BorderSide(
              width: 1,
              color: RoomahColors.primaryAccent,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            textStyle: RoomahTextStyle.labelMedium,
            shape: RoundedRectangleBorder()),
        useMaterial3: true,
      ),
    );
  }
}
