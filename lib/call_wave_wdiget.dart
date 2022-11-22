import 'package:flutter/material.dart';

class RecordWaveWidget extends StatefulWidget {

  final CallWaveController controller;

  const RecordWaveWidget({super.key, required this.controller});

  @override
  State<RecordWaveWidget> createState() => _RecordWaveWidgetState();
}

class _RecordWaveWidgetState extends State<RecordWaveWidget> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: widget.controller.firstWaveAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: 1 - widget.controller.firstWaveAnimation.value,
                  child: Container(
                    width: 200 * widget.controller.firstWaveAnimation.value,
                    height: 200 * widget.controller.firstWaveAnimation.value,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.9),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: widget.controller.secondWaveAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: 1 - widget.controller.secondWaveAnimation.value,
                  child: Container(
                    width: 200 * widget.controller.secondWaveAnimation.value,
                    height: 200 * widget.controller.secondWaveAnimation.value,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.8),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedScale(
              scale: widget.controller.firstWaveAnimation.value,
              curve: Curves.easeInOutSine,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:  Colors.purple,
                  border: Border.fromBorderSide(BorderSide(
                      width: (widget.controller.firstWaveAnimation.value * 10)
                          .clamp(2, double.infinity),
                      color:  Colors.purple)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.blue.withOpacity(0.5),
                  //     blurRadius: 0,
                  //     spreadRadius: 5,
                  //   ),
                  // ],
                ),
                child: const Icon(
                  Icons.mic, color: Colors.white,size: 45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CallWaveController extends ChangeNotifier{
  late final AnimationController _controller;
  late final Animation<double> firstWaveAnimation;
  late final Animation<double> secondWaveAnimation;
  final SingleTickerProviderStateMixin providerStateMixin;

  CallWaveController(this.providerStateMixin){
    init();
  }

  void startAnimation(){
    _controller.repeat();
  }

  void stopAnimation(){
    _controller.stop();
  }

  void init() {
    _controller = AnimationController(
      vsync: providerStateMixin,
      duration: const Duration(
        seconds: 2,
      ),
    );
    firstWaveAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.7, curve: Curves.linear),
        ));
    secondWaveAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 1.0, curve: Curves.linear)));

    _controller.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   _controller.repeat();
      // }
    });
    _controller.addListener(() {
      notifyListeners();
    });
  }
}