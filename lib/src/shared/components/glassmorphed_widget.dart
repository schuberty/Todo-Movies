import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphedWidget extends StatelessWidget {
  final double offset;
  final Widget? child;

  const GlassmorphedWidget({
    this.offset = 0.0,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: offset, sigmaY: offset),
        child: child,
      ),
    );
  }
}
