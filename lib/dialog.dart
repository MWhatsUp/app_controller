import 'package:flutter/material.dart';
import 'state/state.dart' as state;

void show({
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
}) {
  var context = state.appContext;

  assert(context.mounted,
  "BuildContext was used even though it was not mounted");

  if (!context.mounted) {
    return;
  }

  showDialog(
    context: context,
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    traversalEdgeBehavior: traversalEdgeBehavior,
  );
}

void showAlert({
  String? title,
  required Widget content,
  List<Widget>? actions,
  EdgeInsetsGeometry? titleBoxPadding,
  EdgeInsetsGeometry? titlePadding,
  EdgeInsetsGeometry? contentPadding,
  Color? titleColor,
  Color? titleBorderColor,
  Color? backgroundColor,
  double? titleBorderSize,
}) {
  var context = state.appContext;

  assert(context.mounted,
  "BuildContext was used even though it was not mounted");

  if (!context.mounted) {
    return;
  }

  Widget? titleWidget;

  if (title != null && title.isNotEmpty) {
    titleWidget = Column(
      children: [
        Row(
          children: [
            Padding(
              padding: titlePadding?? const EdgeInsets.all(0),
              child: Text(
                  style: TextStyle(
                    color: titleColor,
                  ),
                  title
              ),
            ),
          ],
        ),
        Divider(
          thickness: titleBorderSize?? 1,
          color: titleBorderColor?? Colors.transparent,
        )
      ],
    );
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: titleWidget,
        content: content,
        actions: actions,
        titlePadding: titleBoxPadding,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
      );
    },
  );
}

void showConfirmation({
  required String title,
  required String text,
  required void Function() onConfirmPressed,
  String cancelButtonText = "Cancel",
  String confirmButtonText = "Confirm",
}) {
  var context = state.appContext;

  assert(context.mounted,
  "BuildContext was used even though it was not mounted");

  if (!context.mounted) {
    return;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [

          TextButton(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          TextButton(
            child: Text(confirmButtonText),
            onPressed: () async {
              Navigator.of(context).pop();
              onConfirmPressed();
            },
          ),

        ],
      );
    },
  );
}