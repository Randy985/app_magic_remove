import 'package:flutter/material.dart';

class IntroSlide1 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide1({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5F8FF), Color(0xFFEAF0FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          top: -40,
          left: -40,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C8CFF).withValues(alpha: .25),
                  const Color(0xFF6C8CFF).withValues(alpha: .08),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 90,
          right: -30,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF9BB7FF).withValues(alpha: .18),
                  const Color(0xFF9BB7FF).withValues(alpha: .05),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -30,
          left: -20,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF6C8CFF).withValues(alpha: .20),
                  const Color(0xFF6C8CFF).withValues(alpha: .05),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 50,
          right: -20,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4F6BFF).withValues(alpha: .15),
                  const Color(0xFF4F6BFF).withValues(alpha: .05),
                ],
              ),
            ),
          ),
        ),

        Transform.translate(
          offset: const Offset(0, -40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_fix_high_rounded,
                        color: Color(0xFF3D5AFE),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF0F1A33),
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.6,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF425073),
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
