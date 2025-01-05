import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BeautifulAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMessageTap;

  const BeautifulAppBar({
    super.key,
    required this.hintText,
    this.onNotificationTap,
    this.onMessageTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueAccent,
            Color(0xFF2196F3), // A slightly darker blue
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x4D000000),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        IconlyLight.search,
                        color: Colors.blueAccent,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              _buildIconButton(
                icon: IconlyLight.notification,
                onTap: onNotificationTap,
                badge: true,
              ),
              _buildIconButton(
                icon: IconlyLight.message,
                onTap: onMessageTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    VoidCallback? onTap,
    bool badge = false,
  }) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          onPressed: onTap,
        ),
        if (badge)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
