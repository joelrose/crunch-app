import 'package:flutter/material.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/base_model.dart';
import 'package:provider/provider.dart';

class BaseScreen<T extends BaseModel> extends StatefulWidget {
  const BaseScreen({required this.builder, required this.onModelReady});

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  @override
  _BaseScreenState<T> createState() => _BaseScreenState<T>();
}

class _BaseScreenState<T extends BaseModel> extends State<BaseScreen<T>> {
  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
