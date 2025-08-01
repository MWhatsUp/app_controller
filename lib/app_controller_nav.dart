import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'app_controller.dart' as state;

Future<void> refreshApp({bool forceRedraw = false}) async {
  if (!state.isContextLoaded || !state.appContext.mounted) {
    assert(false,
    "App Context was not loaded or not mounted");

    return;
  }

  // Ensure refresh is not called during a widget build
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    await SchedulerBinding.instance.endOfFrame;

    if (!state.appContext.mounted) {
      assert(false, "App Context was not mounted");
      return;
    }
  }

  if (forceRedraw) {
    state.keyValue = state.keyValue == 0? 1 : 0;
  }
  state.appRefreshFn(() {});
}

void openPage(Widget page, {bool forceRedraw = false})
{
  state.currentPage = page;
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

  Navigator.of(context).pop();
}

void closeAllSubPages({BuildContext? context}) {
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

  Navigator.of(context).popUntil((route) => route.isFirst);
}

bool canPop({BuildContext? context}) {
  if (context == null && (!state.isContextLoaded || !state.appContext.mounted)) {
    assert(false,
    "App Context was not loaded or not mounted");

    return false;
  }
  if (context != null && !context.mounted) {
    assert(false,
    "Provided Context was not loaded or not mounted");

    return false;
  }
  context = context?? state.appContext;

  return Navigator.canPop(context);
}

bool canNotPop({BuildContext? context}) {
  if (context == null && (!state.isContextLoaded || !state.appContext.mounted)) {
    assert(false,
    "App Context was not loaded or not mounted");

    return true;
  }
  if (context != null && !context.mounted) {
    assert(false,
    "Provided Context was not loaded or not mounted");

    return true;
  }
  context = context?? state.appContext;

  return !Navigator.canPop(context);
}