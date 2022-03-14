import 'package:flutter/material.dart';

/// Class use to render an animated icon with rotation
class EHRotateIcon extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  EHRotateIcon({Key? key, this.child, this.duration}) : super(key: key);

  @override
  _EHRotateIconState createState() =>
      _EHRotateIconState(child: child, duration: duration);
}

class _EHRotateIconState extends State<EHRotateIcon>
    with SingleTickerProviderStateMixin {
  /// Controller to animate the children
  AnimationController? _animationController;

  /// Widget (icon) to show into the dialog
  final Widget? child;

  /// Duration for the animation
  final Duration? duration;

  _EHRotateIconState({this.child, this.duration = const Duration(seconds: 1)}) {
    _animationController = new AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController!.repeat();
  }

  @override
  void dispose() {
    if (mounted) {
      _animationController!.dispose();

      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      child: child,
      builder: (BuildContext context, Widget? _widget) {
        return new Transform.rotate(
          angle: _animationController!.value * 6.3,
          child: _widget,
        );
      },
    );
  }
}
