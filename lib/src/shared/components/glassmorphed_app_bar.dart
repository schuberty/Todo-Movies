import 'package:flutter/material.dart';
import 'package:todo_movies/src/shared/app_constants.dart';
import 'package:todo_movies/src/shared/components/glassmorphed_widget.dart';

class GlassmorphedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double offset;
  final double opacity;

  const GlassmorphedAppBar({
    this.offset = 5.0,
    this.opacity = 0.7,
    super.key,
  })  : assert(offset >= 0),
        assert(opacity >= 0.0 && opacity <= 1.0);

  @override
  Widget build(BuildContext context) {
    return Glassmorphed(
      offset: offset,
      child: AppBar(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: cAppBarColor.withOpacity(0.5),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
