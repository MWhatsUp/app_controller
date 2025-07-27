import 'package:flutter/material.dart';
import 'state/state.dart' as state;

void show({
  BuildContext? context,
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
  if (context == null && (!state.isContextLoaded || !state.appContext.mounted)) {
    assert(false,
    "App Context was not loaded or not mounted");

    return;
  }
  if (context != null && !context.mounted) {
    assert(false,
    "Provided Context was not loaded or not mounted");

    return;
  }
  context = context?? state.appContext;

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
  BuildContext? context,
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
  if (context == null && (!state.isContextLoaded || !state.appContext.mounted)) {
    assert(false,
    "App Context was not loaded or not mounted");

    return;
  }
  if (context != null && !context.mounted) {
    assert(false,
    "Provided Context was not loaded or not mounted");

    return;
  }
  context = context?? state.appContext;

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
  BuildContext? context,
  required String title,
  required String text,
  required void Function() onConfirmPressed,
  String cancelButtonText = "Cancel",
  String confirmButtonText = "Confirm",
}) {
  if (context == null && (!state.isContextLoaded || !state.appContext.mounted)) {
    assert(false,
    "App Context was not loaded or not mounted");

    return;
  }
  if (context != null && !context.mounted) {
    assert(false,
    "Provided Context was not loaded or not mounted");

    return;
  }
  context = context?? state.appContext;

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