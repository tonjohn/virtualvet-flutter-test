import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_appbar_state.dart';

class BottomAppBarCubit extends Cubit<BottomAppBarState> {
  BottomAppBarCubit() : super(SelectedBarItem(0));

  void selectItem(int index) {
    emit(SelectedBarItem(index));
  }
}
