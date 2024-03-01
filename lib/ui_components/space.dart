import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;
  const Space({
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
