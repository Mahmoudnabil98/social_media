import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static navigationPushNamed(String name, {dynamic data}) {
    navigatorKey.currentState?.pushNamed(name);
  }

  static navigationPushReplacementNamed(String name) {
    navigatorKey.currentState?.pushReplacementNamed(name);
  }

  static navigationPopNamed(String name) {
    navigatorKey.currentState?.popAndPushNamed(name);
  }

  static navigationPop() {
    navigatorKey.currentState?.pop();
  }
}
