import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/injector/injector.dart';
import 'package:flutter_application_1/routing/app_router.dart';
import 'package:flutter_application_1/utils/app_bloc_observer.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await configCoreInjector(getIt);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  void initUniLinks() async {
    final appLinks = AppLinks();
    try {
      final initialLink = await appLinks.getInitialLink();
      _handleDeepLink(initialLink);
    } catch (e) {
      // handle error
    }

    appLinks.uriLinkStream.listen((Uri? link) {
      _handleDeepLink(link);
    });
  }

  void _handleDeepLink(Uri? uri) {
    if (uri == null) return;

    log(uri.toString(), name: 'Deep Link');

    if (uri.scheme == 'myapp' && uri.host == 'open.my.app') {
      final jobId = int.tryParse(uri.queryParameters['jobId'] ?? '');
      final tenantId = uri.queryParameters['tenantId'] ?? '';
      if (jobId != null) {
        // Dùng navigatorKey.currentContext điều hướng với go_router
        final context = navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(
            context,
          ).go('/rams-documents/$jobId', extra: {'tenantId': tenantId});
        }
        if (kDebugMode) {
          print('Received jobId: $jobId');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
