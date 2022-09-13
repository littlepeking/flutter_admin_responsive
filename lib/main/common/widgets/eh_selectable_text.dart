import 'package:flutter/material.dart';

class EHSelectableText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const EHSelectableText(
      {Key? key, required this.text, this.size, this.color, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: TextStyle(
        fontSize: size ?? Theme.of(context).textTheme.bodyLarge!.fontSize,
        color: color ?? Theme.of(context).textTheme.bodyLarge!.color,
        fontWeight: weight ?? Theme.of(context).textTheme.bodyLarge!.fontWeight,
      ),
    );
  }
}
