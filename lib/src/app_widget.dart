import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_modules.dart';
import 'shared/app/router.dart';
import 'shared/app/theme.dart';

class TodoMoviesApp extends StatelessWidget {
  const TodoMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appModules,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        onGenerateRoute: AppRouter.onGenerateRoutes,
      ),
    );
  }
}
