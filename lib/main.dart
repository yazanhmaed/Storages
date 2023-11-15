import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:storage/db/db_helper.dart';

import 'package:storage/generated/l10n.dart';
import 'package:storage/screens/home_screen/cubit/cubit.dart';
import 'package:storage/screens/home_screen/layout_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MicroCubit()..createDatabase(),
      child: MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: const LayoutScreen(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 14,
              height: 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
