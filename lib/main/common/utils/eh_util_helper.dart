class EHUtilHelper {
  static isEmpty(v) {
    return v == null || v.toString().isEmpty;
  }

  static nvl(v, defaultValue) {
    return !isEmpty(v) ? v : defaultValue;
  }

  static bool dateEquals(DateTime? d1, DateTime? d2) {
    if (d1 == null && d2 == null)
      return true;
    else if (d1 == null)
      return false;
    else if (d2 == null)
      return false;
    else
      return d1.isAtSameMomentAs(d2);
  }
}
