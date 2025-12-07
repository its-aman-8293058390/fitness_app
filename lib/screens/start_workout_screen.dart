import 'package:flutter/material.dart';
import 'dart:async'; // Add this import for Timer
import '../models/workout.dart';
import '../utils/constants.dart';

class StartWorkoutScreen extends StatefulWidget {
  final WorkoutDetail workout;

  const StartWorkoutScreen({super.key, required this.workout});

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isRunning = false;
  bool _isPaused = false;
  int _elapsedSeconds = 0;
  late Timer _timer; // This should now work with the import

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      if (!_isRunning) {
        _isRunning = true;
        _isPaused = false;
        _startTimer();
        _animationController.repeat(reverse: true);
      } else if (!_isPaused) {
        _isPaused = true;
        _stopTimer();
        _animationController.stop();
      } else {
        _isPaused = false;
        _startTimer();
        _animationController.repeat(reverse: true);
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _endWorkout() {
    Navigator.pop(context);
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _endWorkout,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Workout in Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Animated circular indicator
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1 + _animation.value * 0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 160,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _formatTime(_elapsedSeconds),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Next Exercise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
              ),
              child: const Column(
                children: [
                  Text(
                    'Mountain Pose',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Stand tall with feet together and arms at your sides',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _endWorkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.stop, size: 30),
                ),
                ElevatedButton(
                  onPressed: _toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  child: Icon(
                    _isRunning && !_isPaused ? Icons.pause : Icons.play_arrow,
                    size: 30,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.skip_next, size: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}