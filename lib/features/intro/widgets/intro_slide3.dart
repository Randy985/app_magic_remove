import 'package:flutter/material.dart';

class IntroSlide3 extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroSlide3({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFAF3), Color(0xFFFFF3E3), Color(0xFFFFEBD8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(
          top: 110,
          right: -20,
          child: Container(
            width: 150,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFB86C).withValues(alpha: .32),
                  const Color(0xFFFFB86C).withValues(alpha: .06),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        Positioned(
          top: 260,
          left: 10,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF9E80).withValues(alpha: .24),
                  const Color(0xFFFF9E80).withValues(alpha: .08),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 60,
          right: 0,
          child: Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFC67B).withValues(alpha: .22),
                  const Color(0xFFFFC67B).withValues(alpha: .05),
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
                        color: Colors.white.withValues(alpha: .92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.flash_on_rounded,
                        color: Color(0xFFE67E22),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF3C2F2A),
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
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
                    color: const Color(0xFF5E4A3E),
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
