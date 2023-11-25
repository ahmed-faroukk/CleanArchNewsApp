import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoveButton extends StatefulWidget {
  final Function() onClick;

  const LoveButton({Key? key, required this.onClick}) : super(key: key);

  @override
  _LoveButtonState createState() => _LoveButtonState();
}

class _LoveButtonState extends State<LoveButton> {
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return _buildLoveBtn();
  }

  Widget _buildLoveBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90, top: 10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: isLoved ? Colors.red : Colors.grey,
          boxShadow: [
            BoxShadow(
              color: isLoved ? Colors.redAccent : Colors.grey,
              offset: Offset(0, isLoved ? 4.0 : -4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLoved = !isLoved;
            });
            widget.onClick(); // Invoke the callback function
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 60,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003) // Perspective
                ..rotateX(isLoved ? -0.1 : 0.1), // Rotate based on state
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
