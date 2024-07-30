import 'package:flutter/material.dart'; // استيراد مكتبة المواد من فلاتر لتوفير العناصر الأساسية للواجهة.
import 'package:flutter/services.dart'; // استيراد مكتبة الخدمات من فلاتر للتعامل مع مدخلات لوحة المفاتيح.

class Ball extends StatefulWidget {
  // تعريف فئة Ball التي تمثل واجهة مستخدم يمكن أن تتغير حالتها (StatefulWidget).
  const Ball({super.key}); // منشئ الفئة Ball مع تمرير مفتاح فريد.

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> with SingleTickerProviderStateMixin {
  // حالة الـ Ball، تستخدم SingleTickerProvider لتوفير متحكم الحركة.
  double ballX = 10; // موقع الكرة الأفقي على الشاشة.
  double ballY = 10; // موقع الكرة العمودي على الشاشة.
  double velocityY = 0; // السرعة الرأسية الأولية للكرة.
  final double gravity = 0.5; // تسارع الجاذبية الذي يؤثر على الكرة.
  final double ballSpeed = 20; // سرعة حركة الكرة عند استخدام لوحة المفاتيح.
  final double ballSize = 20; // حجم الكرة.

  late AnimationController _animationController; // متحكم الحركة للكرة.
  late FocusNode _focusNode; // عنصر التركيز لتلقي مدخلات لوحة المفاتيح.

  @override
  void initState() {
    super.initState(); // استدعاء دالة initState من الحالة الأساسية.
    _focusNode =
        FocusNode(); // إنشاء عنصر التركيز لتمكين تلقي مدخلات لوحة المفاتيح.
    _animationController = AnimationController(
      vsync: this, // تعيين مصدر التوقيت لمتابعة تحديث الحركة.
      duration: const Duration(
          milliseconds: 1000), // تحديد مدة الحركة، تقريبا 60 إطار في الثانية.
    )
      ..addListener(_updateBallPosition) // إضافة مستمع لتحديث موقع الكرة.
      ..repeat(); // جعل الحركة تتكرر باستمرار.
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // التخلص من متحكم الحركة عند انتهاء استخدامه.
    _focusNode.dispose(); // التخلص من عنصر التركيز.
    super.dispose(); // استدعاء دالة dispose من الحالة الأساسية.
  }

  void _updateBallPosition() {
    setState(() {
      // تحديث السرعة الرأسية وموقع الكرة في كل إطار.
      velocityY += gravity; // زيادة السرعة الرأسية بتأثير الجاذبية.
      ballY += velocityY; // تحديث الموقع العمودي للكرة.

      // الحصول على أبعاد الشاشة.
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

      // التحقق من التصادم مع أسفل الشاشة.
      if (ballY + ballSize > screenHeight) {
        ballY = screenHeight - ballSize; // ضبط موقع الكرة عند أسفل الشاشة.
        velocityY = -velocityY * 0.7; // جعل الكرة ترتد مع بعض التخميد.
      }

      // التحقق من التصادم مع أعلى الشاشة.
      if (ballY < 0) {
        ballY = 0; // ضبط موقع الكرة عند أعلى الشاشة.
        velocityY = -velocityY; // عكس السرعة الرأسية للكرة.
      }

      // التأكد من بقاء الكرة ضمن الحدود الأفقية للشاشة.
      ballX = ballX.clamp(0.0, screenWidth - ballSize);
    });
  }

  void _handleKeyboardEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      // التحقق من أن الحدث هو ضغط مفتاح.
      double moveX = 0;
      double moveY = 0;

      switch (event.logicalKey.keyLabel) {
        // التحقق من المفتاح الذي تم ضغطه.
        case 'Arrow Up':
          moveY = -ballSpeed; // تحريك الكرة لأعلى.
          break;
        case 'Arrow Down':
          moveY = ballSpeed; // تحريك الكرة لأسفل.
          break;
        case 'Arrow Left':
          moveX = -ballSpeed; // تحريك الكرة لليسار.
          break;
        case 'Arrow Right':
          moveX = ballSpeed; // تحريك الكرة لليمين.
          break;
      }

      setState(() {
        // تحديث موقع الكرة بناءً على مدخلات لوحة المفاتيح.
        ballX = (ballX + moveX)
            .clamp(0.0, MediaQuery.of(context).size.width - ballSize);
        ballY = (ballY + moveY)
            .clamp(0.0, MediaQuery.of(context).size.height - ballSize);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode, // تعيين عنصر التركيز لتلقي مدخلات لوحة المفاتيح.
      onKey: _handleKeyboardEvent, // تحديد دالة معالجة مدخلات لوحة المفاتيح.
      autofocus: true, // تفعيل التركيز تلقائيًا عند بناء الواجهة.
      child: Stack(
        children: [
          Positioned(
            left: ballX, // تعيين الموقع الأفقي للكرة.
            top: ballY, // تعيين الموقع العمودي للكرة.
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  // تحديث موقع الكرة بناءً على حركة السحب باللمس.
                  ballX = (ballX + details.delta.dx * 2)
                      .clamp(0.0, MediaQuery.of(context).size.width - ballSize);
                  ballY = (ballY + details.delta.dy * 2).clamp(
                      0.0, MediaQuery.of(context).size.height - ballSize);
                });
              },
              child: Container(
                width: ballSize, // تعيين عرض الكرة.
                height: ballSize, // تعيين ارتفاع الكرة.
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // جعل الكرة دائرية.
                  color: Color.fromARGB(255, 30, 151, 40), // تعيين لون الكرة.
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
