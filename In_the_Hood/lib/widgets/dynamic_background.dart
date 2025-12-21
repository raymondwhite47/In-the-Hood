import 'package:flutter/material.dart';

class DynamicBackground extends StatelessWidget {
  const DynamicBackground({super.key, required this.screenIndex});

  final int screenIndex;

  static const List<List<Color>> _palettes = [
    [Color(0xFF121232), Color(0xFF1E3A8A)],
    [Color(0xFF0F172A), Color(0xFF0E7490)],
    [Color(0xFF1F2937), Color(0xFF7C3AED)],
    [Color(0xFF111827), Color(0xFF2563EB)],
  ];

  @override
  Widget build(BuildContext context) {
    final List<Color> palette = _palettes[screenIndex % _palettes.length];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: palette,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
