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

import 'package:get/get.dart';

import 'messages_en_US.dart';
import 'messages_zh_CN.dart';

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
