import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;

  AnimatedButton({required this.onPressed});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final AudioCache _audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 1, end: 1.5).animate(_controller);
  }

  void _animate() {
    _controller.forward(from: 0).then((_) {
      _controller.reverse();
      widget.onPressed();
      _playSound();
    });
  }

  void _playSound() async {
    await _audioCache.play('sounds/rotate.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animate,
      child: Transform.scale(
        scale: _animation.value,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/your_image.png', // Bu yerda rasm manzilini ko'rsating
              width: 50, // Rasm kengligini sozlash
              height: 50, // Rasm balandligini sozlash
              fit: BoxFit.cover, // Rasmni joylash usuli
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
