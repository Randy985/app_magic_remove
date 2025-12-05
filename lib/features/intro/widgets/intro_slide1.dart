import 'package:flutter/material.dart';

class IntroSlide1 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide1({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0F24), Color(0xFF111A3A), Color(0xFF18234F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(
          top: 120,
          left: -40,
          child: Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x442E5CFF),
            ),
          ),
        ),

        Positioned(
          bottom: 80,
          right: -30,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x3340A0FF),
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
                  color: Colors.white.withValues(alpha: .8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
