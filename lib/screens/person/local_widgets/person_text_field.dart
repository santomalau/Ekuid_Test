import 'package:ekuidtest/utils/color.dart';
import 'package:flutter/material.dart';

class PersonTextField extends StatelessWidget {
  final label, hint, controller, keyboardType;
  const PersonTextField(
      {Key? key, this.label, this.hint, this.controller, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.black),
          fillColor: Colors.white,
          // labelStyle: TextStyle(color: Colors.blacks),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primarycolor, width: 2.0),
          ),
          focusColor: primarycolor,
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter student $label';
          }
          if (label == 'Age' && int.parse(value) >= 100) {
            return 'Make sure student age is correct';
          }
          return null;
        },
      ),
    );
  }
}
