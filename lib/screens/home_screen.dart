import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _t;

  final images = const [
    "https://images.unsplash.com/photo-1604147706283-cc1b3b3c4401",
    "https://images.unsplash.com/photo-1526772662000-3f88f10405ff",
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
  ];

  final categories = const [
    ("Kurunji", Icons.terrain, Color(0xFF6A11CB), Color(0xFF2575FC)),
    ("Mullai", Icons.forest, Color(0xFF00B09B), Color(0xFF96C93D)),
    ("Marutham", Icons.agriculture, Color(0xFFF7971E), Color(0xFFFFD200)),
    ("Neithal", Icons.water, Color(0xFF24C6DC), Color(0xFF514A9D)),
    ("Palai", Icons.local_fire_department, Color(0xFFFF5F6D), Color(0xFFFFC371)),
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
    _t = CurvedAnimation(parent: _c, curve: Curves.linear);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _rgbHeader() {
    // Animated RGB gradient bar
    return AnimatedBuilder(
      animation: _t,
      builder: (_, __) {
        final shift = (_t.value * 200).toInt();
        return Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF5F6D).withRed((255 - shift).clamp(0, 255)),
                Color(0xFF00C6FF).withBlue((100 + shift).clamp(0, 255)),
                Color(0xFF66BB6A).withGreen((130 + shift).clamp(0, 255)),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              "Discover Jharkhand by Landscapes",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }

  Widget _categoryCard(String title, IconData icon, Color c1, Color c2) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [c1, c2], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: c2.withOpacity(0.35), blurRadius: 16, spreadRadius: 1, offset: const Offset(0, 8)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // TODO: navigate to a listing page for this category
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening $title spots...')));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 30),
                const Spacer(),
                Text(title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                const Text("Tap to explore places", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.87,
      ),
      items: images
          .map((u) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(u, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.55), Colors.transparent],
                      ),
                    ),
                  ),
                ]),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final grid = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      physics: const NeverScrollableScrollPhysics(),
      children: categories
          .map((c) => _categoryCard(c.$1, c.$2, c.$3, c.$4))
          .toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jharkhand Tourism"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _rgbHeader(),
          const SizedBox(height: 16),
          _carousel(),
          const SizedBox(height: 16),
          const Text("Landscapes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          grid,
        ]),
      ),
    );
  }
}
