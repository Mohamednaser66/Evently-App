import 'package:evently/config/theme/theme_manager.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:evently/providers/config_%20provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.router,
        initialRoute: RoutesManager.signIn,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: Provider.of<ConfigProvider>(context).currentTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
        locale:Locale(Provider.of<ConfigProvider>(context).currentLang),
      ),

    );
  }
}
