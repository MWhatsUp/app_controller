import 'package:flutter/material.dart';

void next() {
  if (FocusManager.instance.primaryFocus != null) {
    FocusManager.instance.primaryFocus!.nextFocus();
  }
}

void previous() {
  if (FocusManager.instance.primaryFocus != null) {
    FocusManager.instance.primaryFocus!.previousFocus();
  }
}

void unfocus() {
  if (FocusManager.instance.primaryFocus != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}