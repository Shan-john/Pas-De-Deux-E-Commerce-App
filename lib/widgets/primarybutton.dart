import 'package:flutter/material.dart';

class Primarybutton extends StatelessWidget {
  final Widget widget;
  final void Function()? onpressed;
  const Primarybutton({super.key,required this.widget, this.onpressed,});

  @override
  Widget build(BuildContext context) {
    return   Container(
    
                  width  :double.infinity,
                  height: 45,
                  child: ElevatedButton(
                  
                    onPressed: onpressed, child: widget));
  }
}