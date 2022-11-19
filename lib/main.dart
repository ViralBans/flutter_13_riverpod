import 'package:flutter/material.dart';
import 'package:flutter_13_riverpod/ui/screens/riverpod_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_provider.dart';

void main() {
  initializeServices();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RiverpodScreen(),
    );
  }
}