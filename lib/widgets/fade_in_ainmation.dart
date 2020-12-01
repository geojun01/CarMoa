import 'package:flutter/material.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translateY }

class FadeIn extends StatelessWidget {
  final int delay;
  final Widget child;

  FadeIn({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(_AniProps.translateY, Tween(begin: -20.0, end: 0.0),
          Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: Duration(milliseconds: 300 * delay),
      duration: Duration(milliseconds: 500),
      tween: tween,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(_AniProps.opacity),
          child: Transform.translate(
            offset: Offset(0, value.get(_AniProps.translateY)),
            child: child,
          ),
        );
      },
    );
  }
}
