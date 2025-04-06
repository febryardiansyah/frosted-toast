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
      // theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        // autoDismiss: false,
        child: Row(
          children: [
            Icon(Icons.info),
            SizedBox(width: 8),
            Text('Hello, Frosted Toast!'),
          ],
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Icon(Icons.info),
        //     SizedBox(height: 8),
        //     Text('Hello, Frosted Toast!'),
        //   ],
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: onShowToast,
          child: const Text('Show Toast'),
        ),
      ),
    );
  }
}
