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

  static DateTime getStartTimeOfDay(DateTime dateTime) {
    return new DateTime(
        dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
  }

  static DateTime convertToGMT11AM(DateTime dateTime) {
    return DateTime.utc(
            dateTime.year, dateTime.month, dateTime.day, 11, 0, 0, 0, 0)
        .toLocal();
  }

  static DateTime getGMT11AMOfToday() {
    DateTime d = DateTime.now();
    return convertToGMT11AM(d);
  }
}
