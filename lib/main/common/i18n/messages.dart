import 'package:get/get.dart';
import 'messages/en_US.dart';
import 'messages/zh_CN.dart';

class Messages extends Translations {
  Map<String, Map<String, String>> _message = {};

  @override
  Map<String, Map<String, String>> get keys {
    if (_message.length == 0) {
      _message['en_US'] = enUSMessages;
      _message['zh_CN'] = zhCNMessages;
    }

    return _message;
  }
}
