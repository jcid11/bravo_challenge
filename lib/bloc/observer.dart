import 'package:flutter_bloc/flutter_bloc.dart';

class ObserverBloc extends BlocObserver {
  /// {@macro counter_observer}
  const ObserverBloc();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }

  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    print('OPEN: $bloc');
  }
  @override
  void onClose(BlocBase bloc) {
    print('CLOSE: $bloc');

    // TODO: implement onClose
    super.onClose(bloc);
  }
}