/*
The Code is taken from this repo and updated to be suitable with new flutter versions
check the link here https://github.com/impiiaapp/flutter_app_liqiud_animation/blob/master/lib/main.dart
The functionality is added by Me
I have full understanding of animations but the math in this code is little bit advanced
 */

import 'dart:math' as math;

import 'package:ev_studios_task/page/constants.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class WaterAnimationPage extends StatefulWidget {
  const WaterAnimationPage({Key? key}) : super(key: key);
  @override
  WaterAnimationPageState createState() => WaterAnimationPageState();
}

class WaterAnimationPageState extends State<WaterAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 360,
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    );
    animationController.repeat();
    isPlaying = true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppConstants.redBG,
        floatingActionButton: ElevatedButton(
            child: Text(isPlaying ? "STOP" : "START",
                style: const TextStyle(color: AppConstants.redBG)),
            onPressed: () {
              isPlaying
                  ? animationController.stop()
                  : animationController.repeat();
              setState(() => isPlaying = !isPlaying);

              setState(() {});
            }),
        body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Stack(
            children: [
              Positioned(
                top: size.height / 2,
                left: size.width / 2,
                child: ClipPath(
                  clipper: CircleClipper(),
                  child: CustomPaint(
                    size: AppConstants.kSize,
                    painter: WavePainter(
                        animationController: animationController,
                        isRightDirection: true),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 2,
                left: size.width / 2,
                child: ClipPath(
                  clipper: CircleClipper(),
                  child: CustomPaint(
                    size: AppConstants.kSize,
                    painter: WavePainter(
                        animationController: animationController,
                        isRightDirection: false),
                  ),
                ),
              ),
              Positioned(
                top: size.height / 2,
                left: size.width / 2,
                child: CustomPaint(
                  size: AppConstants.kSize,
                  painter: FlaskPainter(),
                ),
              ),
              Positioned(
                top: size.height / 2,
                left: size.width / 2,
                child: CustomPaint(
                  size: AppConstants.kSize,
                  painter: ReflectionPainter(),
                ),
              ),
            ],
          ),
        ));
  }
}

class ReflectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(-size.width / 2 + 25, -size.height / 2 + 25,
        size.width - 50, size.height - 50);

    var paint = Paint()
      ..colorFilter =
          ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.softLight)
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = AppConstants.kContourColor.withOpacity(0.1)
      ..strokeWidth = 15;

    final reflection = Path();
    reflection.addArc(rect, vector.radians(-10.0), vector.radians(35));
    reflection.addArc(rect, vector.radians(40.0), vector.radians(15));
    reflection.addArc(rect, vector.radians(70.0), vector.radians(5));

    canvas.drawPath(reflection, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class FlaskPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
        -size.width / 2, -size.height / 2, size.width, size.height);

    var paint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = AppConstants.kContourColor
      ..strokeWidth = 10;

    final flask = Path();
    flask.moveTo(math.sin(vector.radians(15.0)) * size.width / 2,
        -math.cos(vector.radians(15.0)) * size.height / 2 - 40);
    flask.arcTo(rect, vector.radians(-75.0), vector.radians(330), false);
    flask.relativeLineTo(0, -40);
    flask.close();

    final topRect = Rect.fromCenter(
        center: Offset(0, -size.height / 2 - 50),
        width: size.width / 3,
        height: 20);
    final topRRect =
        RRect.fromRectAndRadius(topRect, const Radius.circular(10));
    flask.addRRect(topRRect);
    canvas.drawPath(flask, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..addOval(Rect.fromCenter(
        center: const Offset(0, 0),
        width: size.width - 20,
        height: size.height - 20));

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WavePainter extends CustomPainter {
  AnimationController animationController;
  final bool isRightDirection;
  WavePainter(
      {required this.isRightDirection, required this.animationController});
  //static const int kWaveLength = 180;
  @override
  void paint(Canvas canvas, Size size) {
    double xOffset = size.width / 2;
    List<Offset> polygonOffsets = [];

    for (int i = -xOffset.toInt(); i <= xOffset; i++) {
      polygonOffsets.add(Offset(
          i.toDouble(),
          isRightDirection
              ? math.sin(vector.radians(
                              i.toDouble() * 360 / AppConstants.kWaveLength) -
                          vector.radians(animationController.value)) *
                      20 -
                  25
              : math.sin(vector.radians(
                              i.toDouble() * 360 / AppConstants.kWaveLength) +
                          vector.radians(animationController.value)) *
                      20 -
                  20));
    }

    final Gradient gradient = LinearGradient(
        begin: const Alignment(-1.0, -1.0), //top
        end: const Alignment(-1.0, 1.0), //center
        colors: const <Color>[
          AppConstants.kTopColor,
          AppConstants.kBottomColor,
        ],
        stops: [
          isRightDirection ? 0.1 : 0.4,
          isRightDirection ? 0.9 : 1
        ]);
    final wave = Path();
    wave.addPolygon(polygonOffsets, false);
    wave.lineTo(xOffset, size.height);
    wave.lineTo(-xOffset, size.height);
    wave.close();

    final rect = Rect.fromLTWH(
        0.0,
        isRightDirection ? -size.height / 5 - 25 : -size.height / 5 - 22,
        size.width,
        size.height / 2);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;
    //  canvas.drawRect(rect, paint);
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
