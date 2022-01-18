import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SizedBox(
              height: 40,
              child: const DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Center(child: Text("test1"))))),
      Expanded(child: Container())
    ]);
  }
}
