import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class IbeereDecorativeBackground extends StatelessWidget {
  const IbeereDecorativeBackground({
    this.child,
    this.showFloatingShapes = true,
    super.key,
  });

  final Widget? child;
  final bool showFloatingShapes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFAFAFA),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
        ),
        if (showFloatingShapes) ..._buildFloatingShapes(),
        if (child != null) child!,
      ],
    );
  }

  List<Widget> _buildFloatingShapes() {
    return [
      _buildShape(
        top: 20,
        left: 20,
        size: 60,
        color: IbeereDesignTokens.decorativePink,
        shape: ShapeType.circle,
      ),
      _buildShape(
        top: 30,
        left: null,
        right: 100,
        size: 40,
        color: IbeereDesignTokens.decorativeYellow,
        shape: ShapeType.circle,
      ),
      _buildShape(
        top: 100,
        left: null,
        right: 30,
        size: 50,
        color: IbeereDesignTokens.decorativeGreen,
        shape: ShapeType.circle,
      ),
      _buildShape(
        top: 60,
        left: 70,
        size: 30,
        color: const Color(0xFFCBD5E1),
        shape: ShapeType.circle,
        outlined: true,
      ),
      _buildShape(
        top: 50,
        left: 220,
        size: 25,
        color: IbeereDesignTokens.accentCyan,
        shape: ShapeType.triangle,
      ),
      _buildShape(
        top: 80,
        left: null,
        right: 70,
        size: 25,
        color: const Color(0xFF94A3B8),
        shape: ShapeType.diamond,
      ),
      _buildShape(
        bottom: 200,
        left: 30,
        size: 35,
        color: IbeereDesignTokens.decorativeYellow,
        shape: ShapeType.circle,
      ),
      _buildShape(
        bottom: 250,
        left: null,
        right: 50,
        size: 28,
        color: IbeereDesignTokens.decorativePurple,
        shape: ShapeType.square,
      ),
      _buildShape(
        bottom: 150,
        left: 100,
        size: 22,
        color: const Color(0xFF86EFAC),
        shape: ShapeType.circle,
      ),
      _buildShape(
        bottom: 180,
        left: null,
        right: 120,
        size: 30,
        color: const Color(0xFFFFB6C1),
        shape: ShapeType.circle,
        outlined: true,
      ),
      _buildLargeBlob(
        bottom: -50,
        left: -50,
        size: 200,
        color: const Color(0xFFFED7D7),
      ),
      _buildLargeBlob(
        top: 100,
        right: -80,
        size: 250,
        color: const Color(0xFFD9F99D),
      ),
      _buildLargeBlob(
        bottom: 300,
        right: -60,
        size: 180,
        color: const Color(0xFFE0E7FF),
      ),
    ];
  }

  Widget _buildShape({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
    required ShapeType shape,
    bool outlined = false,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : color.withOpacity(0.3),
          border: outlined
              ? Border.all(color: color.withOpacity(0.3), width: 2)
              : null,
          shape: shape == ShapeType.circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: shape == ShapeType.square
              ? BorderRadius.circular(size * 0.2)
              : null,
        ),
        child: shape == ShapeType.triangle
            ? CustomPaint(
                painter: TrianglePainter(color: color.withOpacity(0.3)),
              )
            : shape == ShapeType.diamond
                ? Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(size * 0.1),
                      ),
                    ),
                  )
                : null,
      ),
    );
  }

  Widget _buildLargeBlob({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
        ),
      ),
    );
  }
}

enum ShapeType { circle, square, triangle, diamond }

class TrianglePainter extends CustomPainter {
  TrianglePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class IbeereLogo extends StatelessWidget {
  const IbeereLogo({
    this.size = LogoSize.medium,
    this.showDecorations = true,
    super.key,
  });

  final LogoSize size;
  final bool showDecorations;

  @override
  Widget build(BuildContext context) {
    final height = size == LogoSize.small
        ? 40.0
        : size == LogoSize.medium
            ? 60.0
            : 80.0;

    return SizedBox(
      height: height * 1.5,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (showDecorations) ...[
            Positioned(
              top: -5,
              left: -10,
              child: Icon(
                Icons.star,
                size: height * 0.2,
                color: IbeereDesignTokens.primaryPurple.withOpacity(0.5),
              ),
            ),
            Positioned(
              top: -5,
              right: -10,
              child: CustomPaint(
                size: Size(height * 0.25, height * 0.25),
                painter: SparkPainter(
                  color: IbeereDesignTokens.primaryPurple.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.1,
              right: -15,
              child: Container(
                width: height * 0.15,
                height: height * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: IbeereDesignTokens.decorativePink.withOpacity(0.5),
                ),
              ),
            ),
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    IbeereDesignTokens.primaryPurple,
                    IbeereDesignTokens.primaryPurple.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'ébeere',
                  style: TextStyle(
                    fontSize: height,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: height * 0.15,
                    height: 2,
                    color: IbeereDesignTokens.primaryPurple,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'Games',
                      style: TextStyle(
                        fontSize: height * 0.2,
                        fontWeight: FontWeight.w500,
                        color: IbeereDesignTokens.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    width: height * 0.15,
                    height: 2,
                    color: IbeereDesignTokens.primaryPurple,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum LogoSize { small, medium, large }

class SparkPainter extends CustomPainter {
  SparkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
