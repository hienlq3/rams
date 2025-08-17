import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final logger = Logger(printer: PrettyPrinter());

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      logger.d('onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      logger.d('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      logger.e('onError -- ${bloc.runtimeType}, $error');
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      logger.d('onClose -- ${bloc.runtimeType}');
    }
  }
}
