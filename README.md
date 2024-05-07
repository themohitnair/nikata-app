# Nikata App

This repository contains the source code for a Flutter application named Nikata. The application is located in the `/home/themohitnair/Skywalker/nikata-app/nikata` directory. The main entry point of the application is located at `lib/main.dart`.

## Main Dart File

The `main.dart` file imports the necessary packages and sets up the application by running `MyApp()`. The `MyApp` class is a `StatefulWidget` that initializes a `GlobalKey<ScaffoldState>` for navigation and defines a method `_navigateTo` for navigating to different pages.

## Pages

The application consists of several pages, which are located in the `lib/pages` directory. The following pages are included in the application:

- `profile_page.dart`: An empty `StatelessWidget` that returns a `Scaffold` with an empty app bar.
- `informed_page.dart`: An empty `StatelessWidget` that returns a `Scaffold` with an empty app bar.
- `about_page.dart`: An empty `StatelessWidget` that returns a `Scaffold` with an empty app bar.
- `logout_page.dart`: An empty `StatelessWidget` that returns a `Scaffold` with an empty app bar.
- `essentials.dart`: A utility file that contains custom `AppBar` widgets and a helper function for creating `ListTile` components.

## Structure

The application uses a `MaterialApp` widget as the root of the widget tree. The `home` property of the `MaterialApp` is set to a `Scaffold` that contains the app bar, a drawer, a bottom navigation bar, and the current page based on the selected index of the bottom navigation bar.

The drawer contains a `DrawerHeader` with the application logo and a list of `ListTile` components for navigation to different pages. The `onTap` property of each `ListTile` calls the `_navigateTo` method with the corresponding page as an argument.

The bottom navigation bar contains two items, one for "Your Geofences" and one for "Add Geofence". The selected item is indicated by a yellow background color and a bold font weight. The `onTap` property of each item calls the `_navigateBottomBar` method with the corresponding index as an argument.

## Conclusion

This repository contains the source code for a Flutter application named Nikata. The application consists of several pages, which are navigated to using a bottom navigation bar and a drawer. The main entry point of the application is located at `lib/main.dart`.