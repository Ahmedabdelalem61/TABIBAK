import 'package:flutter/material.dart';
import 'package:tabibak/shared/components/show_alert_dialog.dart';
Future<void> showExceptionAlertDialog(
    BuildContext context, {
      required String title,
      required String message,
    }) =>
    showAlertDialog(
      context,
      title: title,
      content: message,
      defaultActionText: 'OK',
    );
