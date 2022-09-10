import 'package:flutter/widgets.dart';

class RouteAnimator {
  const RouteAnimator._();

  static PageRouteBuilder rightToLeftRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, _, child) => SlideTransition(
        position: slideAnimation(animation),
        child: child,
      ),
    );
  }

  static Animation<Offset> slideAnimation(
    Animation<double> animation, {
    Offset begin = const Offset(1.0, 0.0),
  }) {
    const end = Offset.zero;

    final curve = CurveTween(curve: Curves.ease);
    final tween = Tween(begin: begin, end: end).chain(curve);
    final slideAnimation = animation.drive(tween);

    return slideAnimation;
  }
}
