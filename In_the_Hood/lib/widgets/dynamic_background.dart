import 'package:flutter/material.dart';

class DynamicBackground extends StatefulWidget {
  final int screenIndex; // based on current tab or route
  const DynamicBackground({super.key, required this.screenIndex});

  @override
  State<DynamicBackground> createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground>
    with SingleTickerProviderStateMixin {
  late final List<String> backgrounds = [
    "assets/images/bg_onboarding.jpg",
    "assets/images/bg_home.jpg",
    "assets/images/bg_auction.jpg",
    "assets/images/bg_chat.jpg",
    "assets/images/bg_profile.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Container(
        key: ValueKey(widget.screenIndex),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgrounds[widget.screenIndex]),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // darken overlay
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }
}
