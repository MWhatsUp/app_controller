import 'package:flutter/material.dart';
import 'state/state.dart' as state;

String previousText = "";
DateTime previousMessageTimeStamp = DateTime.now();

void display({String? text}) {
  if (!state.isContextLoaded || !state.appContext.mounted) {
    assert(false,
    "BuildContext was used even though it was not loaded or not mounted");

    return;
  }
  var context = state.appContext;

  assert(text == null || text.length <= 200,
  "Message to display can not be longer than 200 characters");

  var twoSecondsAfterPrevious = previousMessageTimeStamp.add(
      const Duration(seconds: 2));
  bool shouldClearQueue = DateTime.now().isAfter(twoSecondsAfterPrevious);
  if (shouldClearQueue) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  var oneSecondAfterPrevious = previousMessageTimeStamp.add(
      const Duration(seconds: 1));
  bool isNotSpammingMessage = text != previousText ||
      DateTime.now().isAfter(oneSecondAfterPrevious);

  if (text != null && isNotSpammingMessage) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
      ));
    } catch (exception) {
      if (exception is FlutterError) {
        final String summary = exception.diagnostics.first.toDescription();
        if (summary == 'setState() or markNeedsBuild() called during build.') {
          Future.delayed(const Duration(milliseconds: 10), () {
            display(text: text);
          });
        }
      }
    }
  }

  previousText = text ?? "";
  previousMessageTimeStamp = DateTime.now();
}