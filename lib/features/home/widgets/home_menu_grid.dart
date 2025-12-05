import 'package:flutter/material.dart';
import 'home_menu_button.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ratio = width < 360 ? 0.95 : 1.05;

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
          title: "Eliminar Fondo",
          subtitle: "Quitar fondo automático",
          route: "/remove-bg",
          color: Color(0xFF3D82F0),
        ),
        HomeMenuButton(
          icon: Icons.high_quality_rounded,
          title: "Mejorar Imagen",
          subtitle: "Aumentar calidad",
          route: "/enhance",
          color: Color(0xFF1FA47A),
        ),
        HomeMenuButton(
          icon: Icons.water_drop_rounded,
          title: "Quitar Marca",
          subtitle: "Eliminar watermark",
          route: "/watermark",
          color: Color(0xFFE67E22),
        ),
        HomeMenuButton(
          icon: Icons.face_rounded,
          title: "Corte de Rostro",
          subtitle: "Recorte preciso",
          route: "/face-cutout",
          color: Color(0xFF42A5F5),
        ),
      ],
    );
  }
}
