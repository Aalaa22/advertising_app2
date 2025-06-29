import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'router/go_router_app.dart';
import 'router/local_notifier.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final LocaleChangeNotifier _localeNotifier = LocaleChangeNotifier();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(notifier: _localeNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _localeNotifier,
      builder: (context, _) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              locale: _localeNotifier.locale,
              routerConfig: _router,
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Montserrat',
                textTheme: Typography.englishLike2018.apply(
                  fontSizeFactor: 1.sp,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
