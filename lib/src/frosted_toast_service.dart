part of 'frosted_toast_component.dart';

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
  static OverlayEntry? _overlayEntry;
  static _FrostedToastComponentState? _toastState;

  static bool get isInitialized => _overlayKey.currentState?.mounted == true;

  static void showToast(
    BuildContext context, {
    FrostedToastOptions options = const FrostedToastOptions(),
  }) {
    _checkInitialize();
    dismissToast();

    _overlayEntry = OverlayEntry(
      builder: (context) => FrostedToastComponent(
        options: FrostedToastOptions(
          message: options.message,
          alignment: options.alignment,
          isDarkBackground: options.isDarkBackground,
          child: options.child,
          insetsPadding: options.insetsPadding,
          autoDismissDuration: options.autoDismissDuration,
          autoDismiss: options.autoDismiss,
          onInit: (state) => _toastState = state,
        ),
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _toastState = null;
        },
      ),
    );

    if (_overlayEntry != null) _overlayKey.currentState?.insert(_overlayEntry!);
  }

  static void dismissToast() {
    _checkInitialize();
    if (_toastState != null) {
      _toastState?.dismiss();
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static void _checkInitialize() {
    if (!isInitialized) {
      throw Exception(
          '''FrostedToastOverlay is not initialized. Please wrap your app with FrostedToastOverlay.
            Example:   
              return MaterialApp(
                title: 'Flutter Demo',
                home: const MyHomePage(title: 'Flutter Demo Home Page'),
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return FrostedToastOverlay(
                    child: child ?? const MyHomePage(title: 'Flutter Demo Home Page'),
                  );
                },
              );
          ''');
    }
  }

  static GlobalKey<OverlayState> get overlayKey => _overlayKey;
}
