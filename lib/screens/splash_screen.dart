import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _t = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Animated neon/glow with soft pulsing shadow & RGB gradient ring
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _t,
          builder: (_, __) {
            final blur = 20 + 30 * _t.value;
            final spread = 1 + 3 * _t.value;
            final size = 120.0 + 10 * sin(_t.value * pi);
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size + 120,
                  height: size + 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Color(0xFFFF5F6D),
                        Color(0xFFFFC371),
                        Color(0xFF00C6FF),
                        Color(0xFF0072FF),
                        Color(0xFF6A11CB),
                        Color(0xFF2575FC),
                        Color(0xFFFF5F6D),
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.25),
                          blurRadius: blur,
                          spreadRadius: spread,
                        ),
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: blur / 1.5,
                          spreadRadius: spread / 1.5,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.35),
                        blurRadius: blur,
                        spreadRadius: spread,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  child: Column(
                    children: const [
                      SizedBox(height: 140),
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text("Preparing your journey...",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
