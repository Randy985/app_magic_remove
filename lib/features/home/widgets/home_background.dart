import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF2F6FA), Color(0xFFE6EBF2)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -90,
            left: -80,
            child: _WaveCircle(size: 260, color: Color(0xFFBCD4FF)),
          ),
          Positioned(
            bottom: -120,
            right: -40,
            child: _WaveCircle(size: 310, color: Color(0xFFA8D2FF)),
          ),
          Positioned(
            top: 200,
            right: -70,
            child: _WaveCircle(size: 210, color: Color(0xFFD8E4FF)),
          ),
        ],
      ),
    );
  }
}

class _WaveCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _WaveCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: .45),
      ),
    );
  }
}
