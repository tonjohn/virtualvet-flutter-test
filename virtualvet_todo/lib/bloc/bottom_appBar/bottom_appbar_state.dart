import 'package:equatable/equatable.dart';

abstract class BottomAppBarState extends Equatable {
  const BottomAppBarState();

  @override
  List<Object> get props => [];
}

class SelectedBarItem extends BottomAppBarState {
  // selected bottom app bar item index
  final int itemIndex;
  const SelectedBarItem(this.itemIndex);

  @override
  List<Object> get props => [itemIndex];
}
