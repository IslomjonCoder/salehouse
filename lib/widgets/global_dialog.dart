import 'package:crm/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class GlobalDialog {
  static void showSystemDialog(
      BuildContext context, {
        required String title,
        required String message,
        required String okButtonText,
        Color backgroundColor = Colors.white,
        required Color buttonColor,
        required String cancelButtonText,
        Color cancelButtonColor = Colors.black,
        VoidCallback? onOkPressed,
      }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return isAndroid()
            ? _androidDialog(context, title, message, okButtonText, backgroundColor, buttonColor,
            cancelButtonText, cancelButtonColor, onOkPressed)
            : _iosDialog(context, title, message, okButtonText, backgroundColor, buttonColor,
            cancelButtonText, cancelButtonColor, onOkPressed);
      },
    );
  }

  static Widget _androidDialog(
      BuildContext context,
      String title,
      String message,
      String okButtonText,
      Color backgroundColor,
      Color buttonColor,
      String cancelButtonText,
      Color cancelButtonColor,
      VoidCallback? onOkPressed
      ) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: backgroundColor,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _dialogButton(
              onPressed: () => Navigator.of(context).pop(),
              text: cancelButtonText,
              textColor: cancelButtonColor,
            ),
            _dialogButton(
              onPressed: () {
                onOkPressed?.call();
              },
              text: okButtonText,
              textColor: buttonColor,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _iosDialog(
      BuildContext context,
      String title,
      String message,
      String okButtonText,
      Color backgroundColor,
      Color buttonColor,
      String cancelButtonText,
      Color cancelButtonColor,
      VoidCallback? onOkPressed
      ) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        _dialogButton(
          onPressed: () => Navigator.of(context).pop(),
          text: cancelButtonText,
          textColor: cancelButtonColor,
        ),
        _dialogButton(
          onPressed: (){
            onOkPressed?.call();
          },
          text: okButtonText,
          textColor: buttonColor,
        ),
      ],
    );
  }


  static Widget _dialogButton({
    required VoidCallback onPressed,
    required String text,
    required Color textColor,
  }) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(TColors.tPrimaryColor),
        foregroundColor: MaterialStateProperty.all(textColor),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }

  static bool isAndroid() {
    return !Platform.isIOS;
  }
}
