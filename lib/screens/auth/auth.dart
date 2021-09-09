import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return SizedBox.expand(
                //         child: value
                //             ? SignIn(
                //                 key: const ValueKey('SignIn'),
                //                 onRegisterClicked: () {
                //                   showSignInPage.value = false;
                //                   _controller.forward();
                //                 },
                //               )
                //             : Register(
                //                 key: const ValueKey('Register'),
                //                 onSignInPressed: () {
                //                   showSignInPage.value = true;
                //                   _controller.reverse();
                //                 },
                //               ),
                //     );
                //   },
                // ),
              );
                  }
      )))]));
  }
}