import 'package:flutter/material.dart';

late BuildContext appContext;
late void Function(void Function() fn) appRefreshFn;
int keyValue = 0;
Widget currentPage = const BlankPage();
late ThemeData theme;
bool isContextLoaded = false;

void init({
  required void Function(void Function() fn) refreshFn,
  required Widget startPage,
}) {
  appRefreshFn = refreshFn;
  currentPage = startPage;
}


class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
      );
}

class PageController extends StatelessWidget {
  const PageController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    appContext = context;
    theme = Theme.of(context);
    isContextLoaded = true;

    return Container(
        key: ValueKey(keyValue),
        child: currentPage,
    );
  }
}