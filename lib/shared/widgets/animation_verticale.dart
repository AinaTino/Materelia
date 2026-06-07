import 'package:flutter/material.dart';

enum AnimationVerticaleDirection {
  fromTop,
  fromBottom,
}

class AnimationVerticale extends StatelessWidget {
  const AnimationVerticale({
    super.key,
    required this.child,
    this.direction = AnimationVerticaleDirection.fromTop,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOut,
  });

  final Widget child;
  final AnimationVerticaleDirection direction;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final begin = direction == AnimationVerticaleDirection.fromTop ? -40.0 : 40.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: 0.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) => Opacity(
        opacity: direction == AnimationVerticaleDirection.fromTop
            ? (40 + value) / 40
            : (40 - value) / 40,
        child: Transform.translate(
          offset: Offset(value, 0),
          child: child,
        ),
      ),
      child: child,
    );
  }
}