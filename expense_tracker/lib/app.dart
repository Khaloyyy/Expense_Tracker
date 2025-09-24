import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import 'routes/router.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter router = ref.watch(goRouteProvider);

    return MaterialApp.router(
      title: 'Expense Tracker', 
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
