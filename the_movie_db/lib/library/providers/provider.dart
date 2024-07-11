import 'package:flutter/material.dart';

class Provider<Model> extends InheritedWidget {
  const Provider({super.key, required super.child, required this.model});

  final Model model;

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider<Model> oldWidget) {
    return model != oldWidget.model;
  }
}
