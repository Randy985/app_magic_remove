import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CameraAnimation extends StatefulWidget {
  const CameraAnimation({Key? key}) : super(key: key);

  @override
  CameraAnimationState createState() => CameraAnimationState();
}

class CameraAnimationState extends State<CameraAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/camera.json',
      controller: _controller,
      repeat: true,
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/loading_animation.json',
      repeat: true,
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}
