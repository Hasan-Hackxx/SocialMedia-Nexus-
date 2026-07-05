import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexus/getGate.dart';

class Nexussplashscreen extends StatefulWidget {
  @override
  _NexusSplashScreenState createState() => _NexusSplashScreenState();
}

class _NexusSplashScreenState extends State<Nexussplashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // إعداد الانيميشن (مدته ثانية ونصف)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // يكرر الحركة ليعطي شعور النبض أو البرق

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // الانتقال للصفحة الرئيسية بعد 3 ثواني
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Getgate()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21), // لون غامق يناسب شعار نيكسوس
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  stops: [
                    _animation.value - 0.2,
                    _animation.value,
                    _animation.value + 0.2,
                  ],
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.8), // هذا هو "البرق" الذي يمر
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(rect);
              },
              child: Transform.scale(
                scale: 1.0 + (_animation.value * 0.05), // حركة نبض خفيفة
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assests/images/nexus.png', // مسار شعارك
                      width: 200,
                    ),
                    Text(
                      'NEXUS',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
