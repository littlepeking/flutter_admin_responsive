import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/localizations.dart';

class CustomSfLocalizationDelegate
    extends LocalizationsDelegate<SfLocalizations> {
  const CustomSfLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'zh';

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
  // TODO: implement allDayLabel
  String get allDayLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewDayLabel
  String get allowedViewDayLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewMonthLabel
  String get allowedViewMonthLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewScheduleLabel
  String get allowedViewScheduleLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewTimelineDayLabel
  String get allowedViewTimelineDayLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewTimelineMonthLabel
  String get allowedViewTimelineMonthLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewTimelineWeekLabel
  String get allowedViewTimelineWeekLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewTimelineWorkWeekLabel
  String get allowedViewTimelineWorkWeekLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewWeekLabel
  String get allowedViewWeekLabel => throw UnimplementedError();

  @override
  // TODO: implement allowedViewWorkWeekLabel
  String get allowedViewWorkWeekLabel => throw UnimplementedError();

  @override
  // TODO: implement daySpanCountLabel
  String get daySpanCountLabel => throw UnimplementedError();

  @override
  // TODO: implement dhualhiLabel
  String get dhualhiLabel => throw UnimplementedError();

  @override
  // TODO: implement dhualqiLabel
  String get dhualqiLabel => throw UnimplementedError();

  @override
  // TODO: implement jumada1Label
  String get jumada1Label => throw UnimplementedError();

  @override
  // TODO: implement jumada2Label
  String get jumada2Label => throw UnimplementedError();

  @override
  // TODO: implement muharramLabel
  String get muharramLabel => throw UnimplementedError();

  @override
  String get ofDataPagerLabel => '/';

  @override
  String get pagesDataPagerLabel => '页';

  @override
  String get rowsPerPageDataPagerLabel => '每页行数';

  @override
  // TODO: implement passwordDialogContentLabel
  String get passwordDialogContentLabel => throw UnimplementedError();

  @override
  // TODO: implement passwordDialogHeaderTextLabel
  String get passwordDialogHeaderTextLabel => throw UnimplementedError();

  @override
  // TODO: implement passwordDialogHintTextLabel
  String get passwordDialogHintTextLabel => throw UnimplementedError();

  @override
  // TODO: implement passwordDialogInvalidPasswordLabel
  String get passwordDialogInvalidPasswordLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfBookmarksLabel
  String get pdfBookmarksLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfEnterPageNumberLabel
  String get pdfEnterPageNumberLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfGoToPageLabel
  String get pdfGoToPageLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfInvalidPageNumberLabel
  String get pdfInvalidPageNumberLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfNoBookmarksLabel
  String get pdfNoBookmarksLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfPaginationDialogCancelLabel
  String get pdfPaginationDialogCancelLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfPaginationDialogOkLabel
  String get pdfPaginationDialogOkLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfPasswordDialogCancelLabel
  String get pdfPasswordDialogCancelLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfPasswordDialogOpenLabel
  String get pdfPasswordDialogOpenLabel => throw UnimplementedError();

  @override
  // TODO: implement pdfScrollStatusOfLabel
  String get pdfScrollStatusOfLabel => throw UnimplementedError();

  @override
  // TODO: implement rabi1Label
  String get rabi1Label => throw UnimplementedError();

  @override
  // TODO: implement rabi2Label
  String get rabi2Label => throw UnimplementedError();

  @override
  // TODO: implement rajabLabel
  String get rajabLabel => throw UnimplementedError();

  @override
  // TODO: implement ramadanLabel
  String get ramadanLabel => throw UnimplementedError();

  @override
  // TODO: implement safarLabel
  String get safarLabel => throw UnimplementedError();

  @override
  // TODO: implement shaabanLabel
  String get shaabanLabel => throw UnimplementedError();

  @override
  // TODO: implement shawwalLabel
  String get shawwalLabel => throw UnimplementedError();

  @override
  // TODO: implement shortDhualhiLabel
  String get shortDhualhiLabel => throw UnimplementedError();

  @override
  // TODO: implement shortDhualqiLabel
  String get shortDhualqiLabel => throw UnimplementedError();

  @override
  // TODO: implement shortJumada1Label
  String get shortJumada1Label => throw UnimplementedError();

  @override
  // TODO: implement shortJumada2Label
  String get shortJumada2Label => throw UnimplementedError();

  @override
  // TODO: implement shortMuharramLabel
  String get shortMuharramLabel => throw UnimplementedError();

  @override
  // TODO: implement shortRabi1Label
  String get shortRabi1Label => throw UnimplementedError();

  @override
  // TODO: implement shortRabi2Label
  String get shortRabi2Label => throw UnimplementedError();

  @override
  // TODO: implement shortRajabLabel
  String get shortRajabLabel => throw UnimplementedError();

  @override
  // TODO: implement shortRamadanLabel
  String get shortRamadanLabel => throw UnimplementedError();

  @override
  // TODO: implement shortSafarLabel
  String get shortSafarLabel => throw UnimplementedError();

  @override
  // TODO: implement shortShaabanLabel
  String get shortShaabanLabel => throw UnimplementedError();

  @override
  // TODO: implement shortShawwalLabel
  String get shortShawwalLabel => throw UnimplementedError();

  @override
  // TODO: implement todayLabel
  String get todayLabel => throw UnimplementedError();

  @override
  // TODO: implement weeknumberLabel
  String get weeknumberLabel => throw UnimplementedError();
}
