import 'package:flutter/material.dart';

class IntroSlide2 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide2({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFDF7FF), Color(0xFFF2ECFF), Color(0xFFE9E2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(
          top: -50,
          right: -30,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFA77BFF).withValues(alpha: .25),
                  const Color(0xFFA77BFF).withValues(alpha: .08),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -20,
          left: -30,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFCEB7FF).withValues(alpha: .22),
                  const Color(0xFFCEB7FF).withValues(alpha: .10),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 160,
          left: 20,
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFB287FF).withValues(alpha: .18),
                  const Color(0xFFB287FF).withValues(alpha: .04),
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
                            color: Colors.black.withValues(alpha: .09),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.high_quality_rounded,
                        color: Color(0xFF8E4BFF),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF2A1F47),
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
                    color: const Color(0xFF4C3E67),
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
