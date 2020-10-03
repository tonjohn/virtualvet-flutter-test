import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(ImageUtils.vetLogo),
      centerTitle: true,
      actions: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: CircleAvatar(
              radius: 23.0,
              backgroundColor: getContext(context).accentColor,
              child: Center(
                child: Image.asset(
                  ImageUtils.message,
                  height: 20,
                ),
              ),
            ),
          ),
          onTap: () => Scaffold.of(context).openEndDrawer(),
        )
      ],
    );
  }

  @override
  Size get preferredSize {
    // gets the current Size of the default AppBar in Flutter
    final prefSize = AppBar().preferredSize;

    return Size(
      prefSize.width,
      prefSize.height,
    );
  }
}
