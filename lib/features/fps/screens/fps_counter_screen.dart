import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FpsCounterScreen extends StatefulWidget {
  const FpsCounterScreen({super.key});

  @override
  State<FpsCounterScreen> createState() => _FpsCounterScreenState();
}

class _FpsCounterScreenState extends State<FpsCounterScreen> {
  late final Timer _timer;

  @override
  void initState() {
    SchedulerBinding.instance.addTimingsCallback(_countFrames);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          _displayCount = _counted;
          _counted = 0;
        });
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    SchedulerBinding.instance.removeTimingsCallback(_countFrames);

    super.dispose();
  }

  /// Counting every frame, and then
  /// every second rewrites to [_displayCount].
  int _counted = 0;

  /// Amount of frames every second.
  int _displayCount = 0;

  void _countFrames(List<FrameTiming> timings) {
    _counted += timings.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            _displayCount.toString(),
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 20),
          const _BasicAnimationWidget(),
        ],
      ),
    );
  }
}

class _BasicAnimationWidget extends StatefulWidget {
  const _BasicAnimationWidget();

  @override
  State<_BasicAnimationWidget> createState() => __BasicAnimationWidgetState();
}

class __BasicAnimationWidgetState extends State<_BasicAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: (pi * 2) * _controller.value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
