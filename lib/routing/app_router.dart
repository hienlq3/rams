import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/ui/rams_documents_page/view/rams_documents_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/rams-documents/:jobId',
    routes: [
      GoRoute(
        path: '/rams-documents/:jobId',
        builder: (context, state) {
          // final jobId = int.tryParse(state.pathParameters['jobId'] ?? '');
          // final tenantId =
          //     (state.extra is Map ? (state.extra as Map)['tenantId'] : '') ??
          //     '';
          final jobId = 1001;
          final tenantId = '52642a7d-e51b-47c7-bd95-1bd48966c8c6';
          return RamsDocumentsPage(
            jobId: jobId,
            tenantId: tenantId,
            // engineerId: 3351635,
            // showOnVisitStatusList: 'Optional',
            // engineerReadStatus: 0,
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(title: ''),
      ),
    ],
    errorPageBuilder:
        (context, state) => const MaterialPage(
          child: Scaffold(body: Center(child: Text('Route not found!'))),
        ),
    // redirect: (context, state) async {
    //   final status = context.read<AuthenticationBloc>().state.status;
    //   switch (status) {
    //     case AuthenticationStatus.authenticated:
    //       if (state.matchedLocation.equalsIgnoreCase(AppRoutes.kLogin)) {
    //         return AppRoutes.kHome;
    //       } else {
    //         return null;
    //       }
    //     case AuthenticationStatus.unauthenticated:
    //       return AppRoutes.kLogin;
    //     case AuthenticationStatus.unknown:
    //       return AppRoutes.kSplash;
    //     case AuthenticationStatus.enteringCode:
    //       return AppRoutes.kSubmitCode;
    //   }
    // },
  );
}
