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

  static String getShortStr(String str, int maxLength,
      {String suffix = '...'}) {
    return str.length > maxLength ? str.substring(0, maxLength) + suffix : str;
  }
}
