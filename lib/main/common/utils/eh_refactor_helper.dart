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
}
