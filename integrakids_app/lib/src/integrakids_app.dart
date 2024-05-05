import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

import 'core/ui/widgets/integrakids_loader.dart';
import 'features/splash/slpash_page.dart';

class IntegrakidsApp extends StatelessWidget {
  const IntegrakidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const IntegrakidsLoader(),
      builder: (AsyncNavigatorObserver) {
        return MaterialApp(
          title: 'Integrakids',
          navigatorObservers: [AsyncNavigatorObserver],
          routes: {
            '/': (_) => const SlpashPage(),
          },
        );
      },
    );
  }
}
