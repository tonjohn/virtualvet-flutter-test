import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              CustomCircle(
                image: ImageUtils.virtualVet,
                title: "VIRTUAL VET",
              ),
              const SizedBox(height: 8.0),
              CustomCircle(
                image: ImageUtils.realVet,
                title: "REAL VET",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircle extends StatelessWidget {
  final String image;
  final String title;

  const CustomCircle({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23.0,
        backgroundColor: getContext(context).accentColor,
        child: Center(
          child: Image.asset(
            image,
            height: 25,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () {},
    );
  }
}
