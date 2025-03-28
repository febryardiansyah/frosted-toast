import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedToastParams {
  final String message;
  final Alignment alignment;
  final bool isDarkBackground;
  final EdgeInsets insetsPadding;

  const FrostedToastParams({
    required this.message,
    this.alignment = Alignment.topCenter,
    this.isDarkBackground = false,
    this.insetsPadding = const EdgeInsets.symmetric(horizontal: 8),
  });
}

class FrostedToastComponent extends StatefulWidget {
  final FrostedToastParams params;
  final VoidCallback onDismiss;

  const FrostedToastComponent({
    super.key,
    required this.params,
    required this.onDismiss,
  });

  @override
  State<FrostedToastComponent> createState() => _FrostedToastComponentState();
}

class _FrostedToastComponentState extends State<FrostedToastComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  FrostedToastParams get params => widget.params;
  bool isBottomPosition = false;

  @override
  void initState() {
    super.initState();
    isBottomPosition = params.alignment.y > 0;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, isBottomPosition ? 1 : -1), // Starts offscreen (top)
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _animationController.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.params.isDarkBackground;

    return SafeArea(
      child: Container(
        alignment: widget.params.alignment,
        margin: widget.params.insetsPadding,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.5) // Glossy effect
                        : Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          widget.params.message,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _animationController
                              .reverse()
                              .then((_) => widget.onDismiss());
                        },
                        child: Icon(
                          Icons.close,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
