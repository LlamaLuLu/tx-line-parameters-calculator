import 'package:flutter/material.dart';
import 'dart:async';

class SwipeImageWidget extends StatefulWidget {
  final List<String> imagePaths;

  const SwipeImageWidget({super.key, required this.imagePaths});

  @override
  _SwipeImageWidgetState createState() => _SwipeImageWidgetState();
}

class _SwipeImageWidgetState extends State<SwipeImageWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  int _cycleCount = 0; // Counts how many times the images have cycled
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_cycleCount >= 2) {
        _timer?.cancel(); // Stop auto-scrolling after two full cycles
        return;
      }
      if (_currentPage < widget.imagePaths.length - 1) {
        // Move to the next image
        _currentPage++;
        _cycleCount++;
      } else {
        // Reached the last image, check if another cycle is needed
        _cycleCount++;
        _currentPage = 0; // Reset to the first image for the next cycle
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 5),
      child: SizedBox(
        height: 190, // Adjust as needed
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(widget.imagePaths[index], fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
