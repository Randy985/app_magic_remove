import 'package:go_router/go_router.dart';

import 'features/intro/intro_page.dart';
import 'features/home/home_page.dart';

import 'features/remove_bg/pages/remove_bg_page.dart';
import 'features/enhance/pages/enhance_page.dart';
import 'features/watermark/pages/watermark_page.dart';
import 'features/face_cutout/pages/face_cutout_page.dart';

GoRouter appRouter(bool seenIntro) {
  return GoRouter(
    initialLocation: seenIntro ? '/home' : '/intro',
    routes: [
      GoRoute(path: '/intro', builder: (_, __) => const IntroPage()),
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),

      GoRoute(path: '/remove-bg', builder: (_, __) => const RemoveBgPage()),
      GoRoute(path: '/enhance', builder: (_, __) => const EnhancePage()),
      GoRoute(path: '/watermark', builder: (_, __) => const WatermarkPage()),
      GoRoute(path: '/face-cutout', builder: (_, __) => const FaceCutoutPage()),
    ],
  );
}
