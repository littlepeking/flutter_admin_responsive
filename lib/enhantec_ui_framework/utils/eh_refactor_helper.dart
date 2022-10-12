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

import 'package:reflectable/reflectable.dart';

// import '../../main/main.reflectable.dart';

class MethodExecutor extends Reflectable {
  const MethodExecutor() : super(invokingCapability);
}

const EHMethodExecutor = MethodExecutor();

class EHRefactorHelper {
  static void setFieldValue(Object object, String fieldName, Object? value) {
    //initializeReflectable();
    var instanceMirror = EHMethodExecutor.reflect(object);
    instanceMirror.invokeSetter(fieldName, value);
  }

  static Object? getFieldValue(Object object, String fieldName) {
    //initializeReflectable();
    var instanceMirror = EHMethodExecutor.reflect(object);
    return instanceMirror.invokeGetter(fieldName);
  }

  static Object? executeMethod(String methodName, Object object,
      List positionalArguments, Map<Symbol, dynamic>? namedArguments) {
    //initializeReflectable();
    var instanceMirror = EHMethodExecutor.reflect(object);
    return instanceMirror.invoke(
        methodName, positionalArguments, namedArguments);
  }
}
