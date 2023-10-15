import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pillar extends StatelessWidget {
  final String pillarId;

  const Pillar(this.pillarId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 4.0),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
        ),
        child: const Text("Pillar", textAlign: TextAlign.center),
      ),
    );
  }
}
