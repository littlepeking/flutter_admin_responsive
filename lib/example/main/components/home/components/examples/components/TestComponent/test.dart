/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SafeArea(
          child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Text("Inner Header"),
                Expanded(
                    child: SizedBox(
                        height: 100,
                        child: const DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: Center(child: Text("test19"))))),
                Expanded(
                  child: Container(
                    height: 300,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 300,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
