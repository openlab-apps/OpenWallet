import 'package:flutter/material.dart';
import 'package:mrt_wallet/app/models/models/typedef.dart' show DynamicVoid;
import 'constraints_box_view.dart';
import 'text_widget.dart';
import 'widget_constant.dart';

SnackBar createSnackAlert(
    {required String message,
    required DynamicVoid onTap,
    required ThemeData theme}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    actionOverflowThreshold: 0,
    elevation: 0,
    content: GestureDetector(
      onTap: onTap,
      child: Center(
        child: ConstraintsBoxView(
          maxWidth: 350,
          child: Card(
            elevation: 3,
            child: Container(
              padding: WidgetConstant.padding10,
              decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: WidgetConstant.border8),
              child: Stack(
                children: [
                  Center(
                    child: OneLineTextWidget(message,
                        maxLine: 3, align: TextAlign.center),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  return snackBar;
}
