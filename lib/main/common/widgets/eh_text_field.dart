import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditPanelController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//注意：如果EHTextField设置了EHTextFieldController，除KEY外的其他属性将不生效。EHTextFieldController与其他属性只允许二选一。
class EHTextField extends EHStatelessWidget<EHTextFieldController> {
  EHTextField({
    Key? key,
    FocusNode? focusNode,
    EHTextFieldController? controller,
    String label = '',
    String text = '',
    Map? errorBucket,
    bool enabled = true,
    bool mustInput = false,
    bool? autoFocus = false,
    this.width = 200,
    ValueChanged<String>? onChanged,
    Function? onEditingComplete,
  }) : super(
            key: key,
            controller: controller ??
                EHTextFieldController(
                    focusNode: focusNode,
                    autoFocus: autoFocus,
                    label: label,
                    text: text,
                    errorBucket: errorBucket,
                    onChanged: onChanged,
                    onEditingComplete: onEditingComplete,
                    enabled: enabled,
                    mustInput: mustInput));

  final double width;

  @override
  Widget build(BuildContext context) {
    if (controller.errorBucket == null)
      controller.errorBucket = EHEditPanelController.globalErrorBucket;

    print('errorBucket ${controller.errorBucket}');
    print('key $key');

    return Obx(() => Container(
          padding: Responsive.isDesktop(context)
              ? EdgeInsets.symmetric(horizontal: 5)
              : EdgeInsets.symmetric(horizontal: 2),
          // height: 70,
          width: this.width,
          child: Column(
            children: [
              EHEditLabel(
                mustInput: controller.mustInput,
                label: controller.label,
              ),
              Container(
                height: 25,
                child: TextField(
                    autofocus: controller.autoFocus,
                    focusNode: controller.focusNode,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: new OutlineInputBorder(),
                    ),
                    onEditingComplete: () {
                      // Move the focus to the next node explicitly.
                      if (controller.onEditingComplete == null) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        controller.onEditingComplete!(context);
                      }
                    },
                    controller: controller._textEditingController,
                    enabled: controller.enabled,
                    onChanged: (v) {
                      if (controller.mustInput) {
                        if (EHUtilHelper.isEmpty(v)) {
                          controller.errorBucket![key] =
                              'This field cannot be empty'.tr;
                        } else {
                          controller.errorBucket![key] = '';
                        }
                      }
                      controller.onChanged!(v);
                    }),
              ),
              EHEditErrorInfo(
                  errorBucket: controller.errorBucket!, errorFieldKey: key)
            ],
          ),
        ));
  }
}

class EHTextFieldController extends EHController {
  EHEditingController _textEditingController = new EHEditingController();
  GlobalKey<State<Tooltip>> tooltipKey = GlobalKey();

  Map? errorBucket;

  FocusNode? focusNode;

  RxBool _autoFocus = false.obs;

  get autoFocus {
    return _autoFocus.value;
  }

  set autoFocus(v) {
    _autoFocus.value = v;
  }

  RxBool _mustInput = false.obs;

  get mustInput {
    return _mustInput.value;
  }

  set mustInput(v) {
    _mustInput.value = v;
  }

  RxString _label = ''.obs;

  get label {
    return _label.value;
  }

  set label(v) {
    _label.value = v;
  }

  RxBool _enabled = true.obs;

  get enabled {
    return _enabled.value;
  }

  set enabled(v) {
    _enabled.value = v;
  }

  set text(val) {
    this._textEditingController.text = val;
  }

  String get text {
    return _textEditingController.text;
  }

  ValueChanged<String>? onChanged;
  Function? onEditingComplete;

  EHTextFieldController(
      {bool? autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      this.onEditingComplete,
      Map? errorBucket}) {
    this.autoFocus = autoFocus;
    this.label = label;
    this.text = text;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.errorBucket = errorBucket;
    this.focusNode = focusNode;
  }
}

class EHEditingController extends TextEditingController {
  @override
  set text(String newText) {
    //resolve  cursor always at first position issue cause by obx.
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }
}
