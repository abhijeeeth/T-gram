class AppConfig {
  static bool get isMimicBuild =>
      const bool.fromEnvironment('MIMIC_BUILD', defaultValue: false);
  static bool get isDebugBuild =>
      !const bool.fromEnvironment('dart.vm.product');

  static bool get shouldBypassSecurity => isMimicBuild || isDebugBuild;
}
