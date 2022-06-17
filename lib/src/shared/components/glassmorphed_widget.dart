import 'dart:ui';

import 'package:flutter/material.dart';

class Glassmorphed extends StatelessWidget {
  final double offset;
  final Widget? child;

  const Glassmorphed({
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
