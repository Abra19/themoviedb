import 'package:flutter/material.dart';

class NotifyProvider<Model extends ChangeNotifier> extends StatefulWidget {
  const NotifyProvider({
    super.key,
    required this.create,
    required this.child,
    this.isManagedModel = true,
  });

  final Model Function() create;
  final Widget child;
  final bool isManagedModel;

  @override
  State<NotifyProvider<Model>> createState() => _NotifyProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifyProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedNotifyProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifyProvider<Model> ? widget.model : null;
  }
}

class _NotifyProviderState<Model extends ChangeNotifier>
    extends State<NotifyProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifyProvider<Model>(
      model: _model,
      child: widget.child,
    );
  }

  // @override
  // void dispose() {
  //   if (widget.isManagedModel) {
  //     _model.dispose();
  //   }
  //   super.dispose();
  // }
}

class _InheritedNotifyProvider<Model extends ChangeNotifier>
    extends InheritedNotifier<Model> {
  const _InheritedNotifyProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);
  final Model model;
}
