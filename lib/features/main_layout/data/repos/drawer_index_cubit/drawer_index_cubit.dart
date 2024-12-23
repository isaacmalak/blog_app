import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_index_state.dart';

class DrawerIndexCubit extends Cubit<int> {
  DrawerIndexCubit() : super(0);
  void newIndex(int newIndex) {
    emit(newIndex);
  }
}
