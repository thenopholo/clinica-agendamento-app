import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

import 'core/ui/utils/integrakids_theme.dart';
import 'core/ui/widgets/clinica_nav_global_key.dart';
import 'core/ui/widgets/integrakids_loader.dart';
import 'features/auth/login/login_page.dart';
import 'features/auth/register/clinica/clinica_register_page.dart';
import 'features/auth/register/user/user_resgister_page.dart';
import 'features/home/adm/home_adm_page.dart';
import 'features/splash/slpash_page.dart';

class IntegrakidsApp extends StatelessWidget {
  const IntegrakidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const IntegrakidsLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Integrakids',
          debugShowCheckedModeBanner: false,
          theme: IntegrakidsTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: ClinicaNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SlpashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserResgisterPage(),
            '/auth/register/create_clinica': (_) => const ClinicaRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const Text('EMPLOYEE'),
          },
        );
      },
    );
  }
}
