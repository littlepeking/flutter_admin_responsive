import 'package:flutter/material.dart';

class EHText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const EHText(
      {Key? key, required this.text, this.size, this.color, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? Theme.of(context).textTheme.bodyLarge!.fontSize,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
        fontWeight: weight ?? Theme.of(context).textTheme.bodyLarge!.fontWeight,
      ),
    );
  }
}
