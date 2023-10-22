import 'package:flutter/material.dart';


class Responsive_Layout extends StatelessWidget {
  final Widget MobielBody;
  final Widget DesktopBody;
  const Responsive_Layout({super.key, required this.MobielBody, required this.DesktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
         
          return MobielBody;
        } else {
         
          return DesktopBody;
        }
      },
    );
  }
}
