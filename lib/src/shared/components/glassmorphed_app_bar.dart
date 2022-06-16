import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_movies/src/shared/app_constants.dart';

class GlassmorphedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double offset;
  final double opacity;

  const GlassmorphedAppBar({
    this.offset = 5.0,
    this.opacity = 0.7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: offset, sigmaY: offset),
        child: AppBar(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: cAppBarColor.withOpacity(opacity),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
