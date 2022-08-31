import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/localizations.dart';

class CustomSfLocalizationDelegate
    extends LocalizationsDelegate<SfLocalizations> {
  const CustomSfLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<SfLocalizations> load(Locale locale) {
    return SynchronousFuture<SfLocalizations>(CustomSfLocalization());
  }

  @override
  bool shouldReload(LocalizationsDelegate<SfLocalizations> old) => false;
}

class CustomSfLocalization extends SfLocalizations {
  CustomSfLocalization();

  @override
  String get noEventsCalendarLabel => 'Pole valitud kuupäeva';

  @override
  String get noSelectedDateCalendarLabel => 'Üritusi pole';

  @override
  // ignore: todo
  // TODO: implement allDayLabel
  String get allDayLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewDayLabel
  String get allowedViewDayLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewMonthLabel
  String get allowedViewMonthLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewScheduleLabel
  String get allowedViewScheduleLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewTimelineDayLabel
  String get allowedViewTimelineDayLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewTimelineMonthLabel
  String get allowedViewTimelineMonthLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewTimelineWeekLabel
  String get allowedViewTimelineWeekLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewTimelineWorkWeekLabel
  String get allowedViewTimelineWorkWeekLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewWeekLabel
  String get allowedViewWeekLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement allowedViewWorkWeekLabel
  String get allowedViewWorkWeekLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement daySpanCountLabel
  String get daySpanCountLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement dhualhiLabel
  String get dhualhiLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement dhualqiLabel
  String get dhualqiLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement jumada1Label
  String get jumada1Label => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement jumada2Label
  String get jumada2Label => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement muharramLabel
  String get muharramLabel => throw UnimplementedError();

  @override
  String get ofDataPagerLabel => '/';

  @override
  String get pagesDataPagerLabel => '页';

  @override
  String get rowsPerPageDataPagerLabel => '每页行数';

  @override
  // ignore: todo
  // TODO: implement passwordDialogContentLabel
  String get passwordDialogContentLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement passwordDialogHeaderTextLabel
  String get passwordDialogHeaderTextLabel => throw UnimplementedError();

  @override
  String get passwordDialogHintTextLabel => throw UnimplementedError();

  @override
  String get passwordDialogInvalidPasswordLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement pdfBookmarksLabel
  String get pdfBookmarksLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement pdfEnterPageNumberLabel
  String get pdfEnterPageNumberLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement pdfGoToPageLabel
  String get pdfGoToPageLabel => throw UnimplementedError();

  @override
  // ignore: todo
  // TODO: implement pdfInvalidPageNumberLabel
  String get pdfInvalidPageNumberLabel => throw UnimplementedError();

  @override
  String get pdfNoBookmarksLabel => throw UnimplementedError();

  @override
  String get pdfPaginationDialogCancelLabel => throw UnimplementedError();

  @override
  String get pdfPaginationDialogOkLabel => throw UnimplementedError();

  @override
  String get pdfPasswordDialogCancelLabel => throw UnimplementedError();

  @override
  String get pdfPasswordDialogOpenLabel => throw UnimplementedError();

  @override
  String get pdfScrollStatusOfLabel => throw UnimplementedError();

  @override
  String get rabi1Label => throw UnimplementedError();

  @override
  String get rabi2Label => throw UnimplementedError();

  @override
  String get rajabLabel => throw UnimplementedError();

  @override
  String get ramadanLabel => throw UnimplementedError();

  @override
  String get safarLabel => throw UnimplementedError();

  @override
  String get shaabanLabel => throw UnimplementedError();

  @override
  String get shawwalLabel => throw UnimplementedError();

  @override
  String get shortDhualhiLabel => throw UnimplementedError();

  @override
  String get shortDhualqiLabel => throw UnimplementedError();

  @override
  String get shortJumada1Label => throw UnimplementedError();

  @override
  String get shortJumada2Label => throw UnimplementedError();

  @override
  String get shortMuharramLabel => throw UnimplementedError();

  @override
  String get shortRabi1Label => throw UnimplementedError();

  @override
  String get shortRabi2Label => throw UnimplementedError();

  @override
  String get shortRajabLabel => throw UnimplementedError();

  @override
  String get shortRamadanLabel => throw UnimplementedError();

  @override
  String get shortSafarLabel => throw UnimplementedError();

  @override
  String get shortShaabanLabel => throw UnimplementedError();

  @override
  String get shortShawwalLabel => throw UnimplementedError();

  @override
  String get todayLabel => throw UnimplementedError();

  @override
  String get weeknumberLabel => throw UnimplementedError();

  @override
  String get pdfHyperlinkContentLabel => throw UnimplementedError();

  @override
  String get pdfHyperlinkDialogCancelLabel => throw UnimplementedError();

  @override
  String get pdfHyperlinkDialogOpenLabel => throw UnimplementedError();

  @override
  String get pdfHyperlinkLabel => throw UnimplementedError();

  @override
  String get series => throw UnimplementedError();
}
