import 'package:flutter/material.dart';
import 'home_menu_button.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ratio = width < 360 ? 0.95 : 1.1;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: ratio,
      ),
      children: const [
        HomeMenuButton(
          icon: Icons.auto_fix_high_rounded,
          label: "Eliminar Fondo",
          route: "/remove-bg",
          color: Color(0xFF3D82F0),
        ),
        HomeMenuButton(
          icon: Icons.high_quality_rounded,
          label: "Mejorar Imagen",
          route: "/enhance",
          color: Color(0xFF1FA47A),
        ),
        HomeMenuButton(
          icon: Icons.water_drop_rounded,
          label: "Quitar Marca",
          route: "/watermark",
          color: Color(0xFFE67E22),
        ),
        HomeMenuButton(
          icon: Icons.face_rounded,
          label: "Corte de Rostro",
          route: "/face-cutout",
          color: Color(0xFF42A5F5),
        ),
      ],
    );
  }
}
