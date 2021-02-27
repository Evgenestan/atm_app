import 'package:atm_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key key, this.onPressed, this.title, this.textColor = Colors.white}) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}
