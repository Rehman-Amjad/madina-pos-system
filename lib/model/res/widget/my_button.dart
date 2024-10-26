import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton{

  Container myCustomButton({required text,required color,required width,required height}){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }



}