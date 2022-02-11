import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHTextField extends EHStatelessWidget<EHTextFieldController> {
  EHTextField(
      {Key? key,
      EHTextFieldController? controller,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.width = 200,
      ValueChanged<String>? onChanged})
      : super(
            key: key,
            controller: controller ??
                EHTextFieldController(
                    label: label,
                    text: text,
                    onChanged: onChanged,
                    enabled: enabled,
                    mustInput: mustInput));

  final double width;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: Responsive.isDesktop(context)
              ? EdgeInsets.symmetric(horizontal: 5)
              : EdgeInsets.symmetric(horizontal: 2),
          // height: 70,
          width: this.width,
          child: Column(
            children: [
              Row(children: [
                SizedBox(width: 5),
                Text(
                  EHUtilHelper.isEmpty(controller.label)
                      ? ''
                      : controller.label + ':',
                  style: TextStyle(
                      fontWeight: EHUtilHelper.isEmpty(controller.error)
                          ? FontWeight.w500
                          : FontWeight.bold,
                      color: EHUtilHelper.isEmpty(controller.error)
                          ? ThemeController.getThemeColor(
                              Colors.white, Colors.black)
                          : ThemeController.getThemeColor(
                              Colors.yellow.shade200, Colors.red)),
                ),
                controller.mustInput
                    ? Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 10,
                        ),
                      )
                    : SizedBox()
              ]),
              Container(
                height: 30,
                child: TextField(
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: new OutlineInputBorder(),
                    ),
                    controller: controller._textEditingController,
                    enabled: controller.enabled,
                    onChanged: (v) {
                      if (controller.mustInput) {
                        if (EHUtilHelper.isEmpty(v)) {
                          controller.error = 'This field cannot be empty'.tr;
                        } else {
                          controller.error = '';
                        }
                      }
                      controller.onChanged!(v);
                    }),
              ),
              Center(
                  child: Text(
                controller.error,
                style: TextStyle(
                    color: ThemeController.getThemeColor(
                        Colors.yellow.shade200, Colors.red)),
              ))
            ],
          ),
        ));
  }
}

class EHTextFieldController extends EHController {
  EHEditingController _textEditingController = new EHEditingController();
  GlobalKey<State<Tooltip>> tooltipKey = GlobalKey();

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

  RxString _error = ''.obs;

  get error {
    return _error.value;
  }

  set error(v) {
    _error.value = v;
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

  EHTextFieldController(
      {String label = '',
      String text = '',
      String error = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged}) {
    this.label = label;
    this.text = text;
    this.error = error;
    this.enabled = enabled;
    this.mustInput = mustInput;
  }
}

class EHEditingController extends TextEditingController {
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }
}
