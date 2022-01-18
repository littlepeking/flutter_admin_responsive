import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  const Test2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SizedBox(
              height: 50,
              child: const DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Center(child: Text("test2"))))),
      Expanded(child: Container())
    ]);
  }
}
