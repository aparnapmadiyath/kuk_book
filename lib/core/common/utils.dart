import 'package:flutter/material.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';

void showSnakbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: CustomTextWidget(text: message)));
}

List setSearchParam({required String param}) {
  List a = param.split(' ');
  return a;
}
