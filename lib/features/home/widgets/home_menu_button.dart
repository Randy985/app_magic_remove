import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final Color color;

  const HomeMenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06)),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: Color.fromRGBO(0, 0, 0, 0.06),
            ),
          ],
        ),

        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
