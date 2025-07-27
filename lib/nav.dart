import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'state/state.dart' as app_state;

Future<void> refreshApp({bool forceRedraw = false}) async {
  if (!app_state.appContext.mounted) {
    assert(false, "App Context was not mounted");
    return;
  }

  // Ensure refresh is not called during a widget build
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    await SchedulerBinding.instance.endOfFrame;

    if (!app_state.appContext.mounted) {
      assert(false, "App Context was not mounted");
      return;
    }
  }

  if (forceRedraw) {
    app_state.keyValue = app_state.keyValue == 0? 1 : 0;
  }
  app_state.appRefreshFn(() {});
}

void openPage(Widget page, {bool forceRedraw = false})
{
  app_state.currentPage = page;
  refreshApp(forceRedraw: forceRedraw);
}

void openSubPage(Widget page,
    {
      BuildContext? context,
      bool canPop = true,
      void Function(bool, dynamic)? onPopInvokedWithResult,
      void Function(dynamic result)? onPageClosed,
    })
{
  context = context?? app_state.appContext;

  if (!context.mounted) {
    assert(false, "Context was not mounted");
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => PopScope(
            canPop: canPop,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              if (onPopInvokedWithResult != null) {
                onPopInvokedWithResult(didPop, result);
              }

              if (didPop && onPageClosed != null) {
                onPageClosed(result);
              }
            },
            child: page,
        )
    ),
  );
}

void closeSubPage({BuildContext? context}) {
  context = context?? app_state.appContext;
  
  if (!context.mounted) {
    assert(false, "Context was not mounted");
    return;
  }

  Navigator.of(app_state.appContext).pop();
}

void closeAllSubPages({BuildContext? context}) {
  context = context?? app_state.appContext;

  if (!context.mounted) {
    assert(false, "Context was not mounted");
    return;
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
}