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
        title: "Elimina Fondos con Precisión IA",
        subtitle:
            "Obtén recortes limpios, nítidos y listos para usar en segundos.",
      ),
      IntroSlide2(
        title: "Mejora la Calidad al Instante",
        subtitle: "Aumenta nitidez, detalle y resolución con un solo toque.",
      ),
      IntroSlide3(
        title: "Edita Rápido. Crea Mejor.",
        subtitle:
            "Un flujo moderno y veloz para transformar tus imágenes sin esfuerzo.",
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

          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Desliza para continuar →",
                style: TextStyle(
                  color: Colors.black.withValues(alpha: .7),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: active ? 26 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),

                    // ACTIVO → Azul vibrante
                    color: active
                        ? const Color(0xFF3D5AFE)
                        : const Color(0xFF333333).withValues(alpha: .45),

                    // SOMBRA SOLO AL ACTIVO
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: const Color(
                                0xFF3D5AFE,
                              ).withValues(alpha: .45),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
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
                      vertical: 12,
                      horizontal: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: .15),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Comenzar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black87,
                          size: 16,
                        ),
                      ],
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
