import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:provider/provider.dart';

import '../../../provider/text_color_provider.dart';



class CustomNeumorphicButton extends StatelessWidget {
  const CustomNeumorphicButton({super.key,
    required this.press,
    required this.width,
    required this.height,
    required this.label,
    required this.isIcon,
  });


  final bool isIcon;
  final String label;
  final double width,height;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final textColorProvider = Provider.of<TextColorProvider>(context,listen: false);
    return NeumorphicButton(
      onTap: press,
      bottomRightShadowBlurRadius: 15,
      bottomRightShadowSpreadRadius: 1,
      borderWidth: 5,
      backgroundColor: Colors.grey.shade500,
      topLeftShadowBlurRadius: 15,
      topLeftShadowSpreadRadius: 1,
      topLeftShadowColor: Colors.black,
      bottomRightShadowColor: Colors.grey.shade500,
      height: height,
      padding: EdgeInsets.zero,
      width: width,
      bottomRightOffset: const Offset(4, 4),
      topLeftOffset: const Offset(-4, -4),
      child: const Center(
          child: Text("Add New", style: TextStyle(color: Colors.black))),
    );
  }
}
