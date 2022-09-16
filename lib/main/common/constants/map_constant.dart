enum SystemModule {
  wms,
  tms,
  system,
  workbench,
}

class MapConstant {
  static const Map<SystemModule, String> systemModuleRoute = {
    SystemModule.wms: '/wmsModule',
    SystemModule.tms: '/tmsModule',
    SystemModule.system: '/systemModule',
    SystemModule.workbench: '/workBench',
  };
}
