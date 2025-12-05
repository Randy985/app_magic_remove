import 'package:flutter/material.dart';

class IntroSlide2 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide2({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B2A49), Color(0xFF3D5AFE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: .08),
                    Colors.white.withValues(alpha: .02),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -40,
          left: -40,
          child: Transform.rotate(
            angle: 0.5,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: .12),
                    Colors.white.withValues(alpha: .03),
                  ],
                ),
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
                  color: Colors.white.withValues(alpha: .85),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
