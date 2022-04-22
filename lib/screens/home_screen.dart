import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftImageNo = Random().nextInt(6) + 1;
  int rightImageNo = Random().nextInt(6) + 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      print(_controller);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftImageNo = Random().nextInt(6) + 1;
          rightImageNo = Random().nextInt(6) + 1;
        });
        print("completed");
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 136, 193, 231),
      appBar: AppBar(
        title: Text("Dicee"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage(
                            "assets/images/dice-png-$leftImageNo.png"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage(
                            "assets/images/dice-png-$rightImageNo.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed:
                roll, //don't use brecket because we want to call when pressed not right now
            child: Text("Roll"),
          )
        ],
      ),
    );
  }
}
