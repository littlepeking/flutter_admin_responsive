import 'package:reflectable/reflectable.dart';

import '../../main.reflectable.dart';

class MethodExecutor extends Reflectable {
  const MethodExecutor() : super(invokingCapability);
}

const methodExecutor = MethodExecutor();

class EHRefactorHelper {
  static void setFieldValue(Object object, String fieldName, Object? value) {
    initializeReflectable();
    var instanceMirror = methodExecutor.reflect(object);
    instanceMirror.invokeSetter(fieldName, value);
  }

  static Object? getFieldValue(Object object, String fieldName) {
    initializeReflectable();
    var instanceMirror = methodExecutor.reflect(object);
    return instanceMirror.invokeGetter(fieldName);
  }

  static Object? executeMethod(String methodName, Object object,
      List positionalArguments, Map<Symbol, dynamic>? namedArguments) {
    initializeReflectable();
    var instanceMirror = methodExecutor.reflect(object);
    return instanceMirror.invoke(
        methodName, positionalArguments, namedArguments);
  }
}
