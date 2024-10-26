import 'package:flutter/cupertino.dart';

import '../../../responsive.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final bool isBold;

  const TextWidget({
    required this.text,
    required this.color,
    required this.size,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Responsive.isMobile(context) ? 12 : size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}