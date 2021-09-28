import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:movielist/service_locator.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    locator<Logger>().i(transition);
    super.onTransition(bloc, transition);
  }
}
