A small library that simplifies controls of your app such as page navigation.

## Features

- Simplifies app controls such as "Navigator.push" to something easier to use.

## Getting started

- Install the package via "flutter pub get app_controller".
- Import the library.
- You are ready to go.

## Usage

Simplify an app control such as Navigator.push by using nav.openSubPage instead: 
```dart
import 'package:flutter/material.dart';
import 'package:app_controller/nav.dart' as nav;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Column(
          children: [
            const Text("Hello"),

            ElevatedButton(
              onPressed: () {
                nav.openSubPage(MenuPage());
              },
              child: const Text("Open Menu"),
            ),
          ],
        ),
      );
}
```

## Additional information

This is just a small project to fulfill my own needs.
