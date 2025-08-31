import 'package:flutter/material.dart';

class CurvedNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _icons = [
    Icons.home,
    Icons.calendar_today,
    Icons.card_travel,
    Icons.info,
    Icons.person,
  ];
  static const _labels = ["Home", "Itinerary", "Packages", "About", "Profile"];

  static const _grads = [
    [Color(0xFFFF5F6D), Color(0xFFFFC371)],
    [Color(0xFF24C6DC), Color(0xFF514A9D)],
    [Color(0xFF00C6FF), Color(0xFF0072FF)],
    [Color(0xFFF7971E), Color(0xFFFFD200)],
    [Color(0xFF00B09B), Color(0xFF96C93D)],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 18, offset: Offset(0, -6))],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          onTap: onTap,
          items: List.generate(_icons.length, (i) {
            final active = currentIndex == i;
            return BottomNavigationBarItem(
              label: _labels[i],
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                padding: EdgeInsets.all(active ? 8 : 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: active
                      ? LinearGradient(colors: _grads[i], begin: Alignment.topLeft, end: Alignment.bottomRight)
                      : null,
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: _grads[i][1].withOpacity(0.6),
                            blurRadius: 18,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          )
                        ]
                      : [],
                ),
                child: Icon(_icons[i], color: active ? Colors.white : Colors.black54, size: active ? 30 : 24),
              ),
            );
          }),
        ),
      ),
    );
  }
}
