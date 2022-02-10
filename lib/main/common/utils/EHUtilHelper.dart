class EHUtilHelper {
  static isEmpty(v) {
    return v == null || v.toString().isEmpty;
  }

  static nvl(v, defaultValue) {
    return !isEmpty(v) ? v : defaultValue;
  }
}
