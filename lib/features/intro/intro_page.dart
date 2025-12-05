import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/intro_slide1.dart';
import 'widgets/intro_slide2.dart';
import 'widgets/intro_slide3.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController controller = PageController();
  int index = 0;

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final slides = const [
      IntroSlide1(
        title: "Elimina Fondos con IA",
        subtitle: "Resultados limpios y profesionales.",
      ),
      IntroSlide2(
        title: "Mejora la Calidad",
        subtitle: "Nitidez y resolución al instante.",
      ),
      IntroSlide3(
        title: "Edita en Segundos",
        subtitle: "Flujo rápido y moderno.",
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // PAGEVIEW
          PageView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (i) => setState(() => index = i),
            children: slides,
          ),

          // INDICADORES
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(slides.length, (i) {
                final active = i == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: active ? 22 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: active
                        ? Colors.white
                        : Colors.white.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),

          // BOTÓN FINAL
          if (index == slides.length - 1)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _finish,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 34,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Comenzar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
