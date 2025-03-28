import 'package:flutter/material.dart';
import 'package:frosted_toast/frosted_toast.dart';

class FrostedToastOverlay extends StatelessWidget {
  final Widget child;
  const FrostedToastOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Overlay(
        key: FrostedToastService.overlayKey,
        initialEntries: [
          OverlayEntry(builder: (context) => Scaffold(body: child)),
        ],
      ),
    );
  }
}

class FrostedToastService {
  static final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  static void showToast(
    BuildContext context,
    String message, {
    Alignment alignment = Alignment.topCenter,
    bool isDarkBackground = false,
  }) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => FrostedToastComponent(
        params: FrostedToastParams(
          message: message,
          alignment: alignment,
          isDarkBackground: isDarkBackground,
        ),
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    _overlayKey.currentState?.insert(overlayEntry);
  }

  static GlobalKey<OverlayState> get overlayKey => _overlayKey;
}
