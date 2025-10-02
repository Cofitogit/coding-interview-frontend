import 'package:flutter/material.dart';
class GrabHandle extends StatelessWidget {
  const GrabHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, top: 8),
        width: 60,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
