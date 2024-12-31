import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom; // Tambahkan parameter bottom

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      backgroundColor: Color(0xFF3DC185),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),

      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0)
    );
  }
}