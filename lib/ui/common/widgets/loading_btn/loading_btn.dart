import 'dart:math' as math;

import 'package:flutter/material.dart';

class _Constants {
  static const double degrees = 360;
}

class LoadingBtn extends StatefulWidget {
  final double iconSize;

  const LoadingBtn({
    this.iconSize = 50,
    super.key,
  });

  @override
  State<LoadingBtn> createState() => _LoadingBtnState();
}

class _LoadingBtnState extends State<LoadingBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    animation = Tween<double>(
      begin: 0,
      end: _Constants.degrees / math.pi, // 2 Radians
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.decelerate,
      ),
    );

    animationController.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5897F),
              Color.fromRGBO(237, 109, 196, 1),
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Transform.rotate(
            angle: animation.value,
            child: Icon(
              Icons.refresh_rounded,
              size: widget.iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
