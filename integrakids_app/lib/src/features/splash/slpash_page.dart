import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

class SlpashPage extends StatelessWidget {
  const SlpashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Page'),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 2)).asyncLoader();
          },
          child: const Text('Teste de Loader'),
        ),
      ),
    );
  }
}
