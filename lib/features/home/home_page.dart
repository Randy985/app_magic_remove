import 'package:flutter/material.dart';
import 'package:magic_remove/core/widgets/banner_ad_widget.dart';
import 'widgets/home_background.dart';
import 'widgets/home_menu_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const HomeBackground(),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.07),
                      ),
                    ],
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            "Magic Remove",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                              letterSpacing: .5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Transforma, mejora y edita tus imágenes con herramientas impulsadas por IA.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.3,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const HomeMenuGrid(),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: const BannerAdWidget(),
          ),
        ],
      ),
    );
  }
}
