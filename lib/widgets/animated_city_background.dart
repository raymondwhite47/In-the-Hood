import 'package:flutter/material.dart';

class AnimatedCityBackground extends StatefulWidget {
  const AnimatedCityBackground({
    super.key,
    required this.imagePath,
    this.transitionDuration = const Duration(milliseconds: 1200),
    this.kenBurnsDuration = const Duration(seconds: 20),
    this.overlayColor = const Color(0xFF000000),
    this.overlayOpacity = 0.5,
  });

  final String imagePath;
  final Duration transitionDuration;
  final Duration kenBurnsDuration;
  final Color overlayColor;
  final double overlayOpacity;

  @override
  State<AnimatedCityBackground> createState() => _AnimatedCityBackgroundState();
}

class _AnimatedCityBackgroundState extends State<AnimatedCityBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<Alignment> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.kenBurnsDuration,
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _alignment = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant AnimatedCityBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kenBurnsDuration != widget.kenBurnsDuration) {
      _controller
        ..duration = widget.kenBurnsDuration
        ..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.transitionDuration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: AnimatedBuilder(
        key: ValueKey(widget.imagePath),
        animation: _controller,
        builder: (context, _) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                  alignment: _alignment.value,
                  colorFilter: ColorFilter.mode(
                    widget.overlayColor.withOpacity(widget.overlayOpacity),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
