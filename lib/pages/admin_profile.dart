import 'package:flutter/material.dart';

class admin_profile extends StatefulWidget {
  const admin_profile({super.key});

  @override
  State<admin_profile> createState() => _admin_profileState();
}

class _admin_profileState extends State<admin_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("haiiiiiiiii")
          ],
        ),
      ),

    );
  }
}