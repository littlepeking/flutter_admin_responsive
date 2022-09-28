import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';

class EHCheckMark extends StatefulWidget {
  EHCheckMark({Key? key}) : super(key: key);

  @override
  _EHCheckMarkState createState() => _EHCheckMarkState();
}

class _EHCheckMarkState extends State<EHCheckMark>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Container(
        margin: EdgeInsets.only(right: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: Colors.green)),
        child: AnimatedCheck(
          strokeWidth: 4,
          progress: _animation,
          color: Colors.green,
          size: 50,
        ));
  }
}
