import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frosted_toast/frosted_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onShowToast() {
    FrostedToastService.showToast(
      context,
      options: const FrostedToastOptions(
        message: 'Hello, Frosted Toast!',
        alignment: Alignment.bottomCenter,
        autoDismiss: true,
        duration: Duration(seconds: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Operation Successful!'),
          ],
        ),
      ),
    );
  }

  void onShowErrorToast() {
    FrostedToastService.showToast(
      context,
      options: const FrostedToastOptions(
        message: 'Error Occurred!',
        alignment: Alignment.topCenter,
        autoDismiss: true,
        duration: Duration(seconds: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Something went wrong!'),
          ],
        ),
      ),
    );
  }

  void onShowLoadingToast() {
    FrostedToastService.showToast(
      context,
      options: const FrostedToastOptions(
        alignment: Alignment.bottomCenter,
        autoDismiss: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoActivityIndicator(),
            SizedBox(width: 8),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  void hideToast() {
    FrostedToastService.dismissToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onShowToast,
              child: const Text('Show Success Toast'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onShowErrorToast,
              child: const Text('Show Error Toast'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onShowLoadingToast,
              child: const Text('Show Loading Toast'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: hideToast,
              child: const Text('Hide Toast'),
            ),
          ],
        ),
      ),
    );
  }
}
