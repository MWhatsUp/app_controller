import 'package:flutter/material.dart';

late BuildContext appContext;
late void Function(void Function() fn) appRefreshFn;
int keyValue = 0;
Widget currentPage = const BlankPage();
late ThemeData theme;
bool isContextLoaded = false;

void init({
  required BuildContext context,
  required void Function(void Function() fn) refreshFn,
  required Widget startPage,
}) {
  appContext = context;
  appRefreshFn = refreshFn;
  currentPage = startPage;
  theme = Theme.of(context);
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

class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    required this.appBuildContext,
    required this.page,
  });

  final BuildContext appBuildContext;
  final Widget page;

  @override
  Widget build(BuildContext containerContext) {
    appContext = appBuildContext;
    theme = Theme.of(appBuildContext);
    isContextLoaded = true;

    return Container(
        key: ValueKey(keyValue),
        child: page,
    );
  }
}