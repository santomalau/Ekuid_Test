import 'package:flutter/material.dart';

class PersonMenuPopUp extends StatelessWidget {
  final String content;
  final Function() function;
  const PersonMenuPopUp(
      {Key? key, required this.content, required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      onTap: function,
    );
  }
}
