import 'package:flutter/material.dart';

class IntroSlide3 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide3({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A), Color(0xFF242424)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),

        Positioned(
          top: 140,
          right: 20,
          child: Container(
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withValues(alpha: .4),
                  Colors.blue.withValues(alpha: .1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 80,
          left: 20,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withValues(alpha: .3),
                  Colors.purple.withValues(alpha: .1),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: .75),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
