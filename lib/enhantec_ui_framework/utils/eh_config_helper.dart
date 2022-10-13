import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:yaml/yaml.dart';

class EHConfigHelper {
  static EHConfigHelper instance = Get.find<EHConfigHelper>();

  late Map configMap;

  EHConfigHelper._create() : super();

  static Future<EHConfigHelper> create() async {
    EHConfigHelper self = EHConfigHelper._create();
    final configFile =
        await rootBundle.loadString('assets/config/eh_config.yaml');

    self.configMap = loadYaml(configFile);
    // print(yamlMap['country']);
    // print(yamlMap['animal']);

    return self;
  }

  Map getConfig() {
    return configMap;
  }

  getConfigItem(String configName) {
    return getConfigItemWithDef(configName, null);
  }

  getConfigItemWithDef(String configName, dynamic defaultValue) {
    var confPath = configName.split('.');

    dynamic subMapOrValue = configMap;

    for (var path in confPath) {
      subMapOrValue = subMapOrValue![path];

      if (subMapOrValue == null) break;
    }

    return subMapOrValue ?? defaultValue;
  }
}
