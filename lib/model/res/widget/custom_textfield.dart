import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField(
      {Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: hoverColor,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        hintStyle: TextStyle(fontSize: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: hoverColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: hoverColor, width: 2.0),
        ),
      ),
      onSubmitted: (String value) {
        debugPrint(value);
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CustomizeTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomizeTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: hoverColor,
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(21),
        hintStyle: TextStyle(fontSize: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      onSubmitted: (String value) {
        debugPrint(value);
      },
    );
  }
}

// class CustomizeTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//
//   const CustomizeTextField(
//       {Key? key, required this.hintText, required this.controller})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       cursorColor: hoverColor,
//       decoration: InputDecoration(
//         hintText: hintText,
//         contentPadding: EdgeInsets.all(21),
//         hintStyle: TextStyle(fontSize: 12),
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white, width: 2.0),
//         ),
//       ),
//       onSubmitted: (String value) {
//         debugPrint(value);
//       },
//     );
//   }
// }
