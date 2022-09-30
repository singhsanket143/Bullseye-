import 'package:flutter/material.dart';

class StylesButton extends StatelessWidget {
  const StylesButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.black,
      splashColor: Colors.redAccent,
      onPressed: onPressed,
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(color: Colors.white, icon),
      ),
    );
  }
}
