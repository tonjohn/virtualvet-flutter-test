import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FABBottomAppBar(
      color: Colors.grey,
      selectedColor: Colors.black,
      backgroundColor: Color(0xFFF7F7F7),
      notchedShape: CircularNotchedRectangle(),
      itemList: [
        FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
        FABBottomAppBarItem(iconData: Icons.layers, text: 'Routine'),
      ],
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatelessWidget {
  FABBottomAppBar({
    this.itemList,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
  }) {
    assert(this.itemList.length == 2 || this.itemList.length == 4);
  }
  final List<FABBottomAppBarItem> itemList;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomAppBarCubit, BottomAppBarState>(
      builder: (context, state) {
        if (state is SelectedBarItem) {
          // builds the bottom appbar widget
          List<Widget> items = List.generate(this.itemList.length, (int index) {
            return _buildTabItem(
              item: itemList[index],
              onTap: () => context.bloc<BottomAppBarCubit>().selectItem(index),
              isSelected: index == state.itemIndex,
            );
          });

          // required to add spacing between items
          items.insert(items.length >> 1, _buildMiddleTabItem());

          return BottomAppBar(
            shape: notchedShape,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            ),
            color: backgroundColor,
          );
        }
        return Offstage();
      },
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: iconSize),
            Text(
              centerItemText ?? '',
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    bool isSelected,
    void Function() onTap,
  }) {
    Color color = isSelected ? selectedColor : this.color;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: iconSize),
                Text(
                  item.text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
