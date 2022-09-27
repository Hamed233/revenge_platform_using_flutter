import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

Future<T?> showPopover<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  required String title,
  EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 8),
}) {
  return showDialog<T>(
    context: context,
    builder: (ctx) => Popover(
      title: title,
      padding: padding,
      child: builder(ctx),
    ),
  );
}

Future<T?> showPopoverWB<T>({
  required BuildContext context,
  GlobalKey<FormState>? key,
  required String title,
  Widget Function(BuildContext)? builder,
  required void Function()? onConfirm,
  TextEditingController? controller,
  String hint = '',
  void Function()? onCancel,
  String? Function(String?)? validator,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8),
  String? cancelText,
  String? confirmText,
  bool hideConfirm = false,
}) {
  final _formKey = key ?? GlobalKey<FormState>();
  return showPopover<T>(
    context: context,
    title: title,
    padding: padding,
    builder: (ctx) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (builder != null) builder(ctx),
        if (controller != null)
          Center(
            child: Container(
              padding: padding,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  controller: controller,
                  onFieldSubmitted: (val) {
                    onConfirm?.call();
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: hint,
                    isDense: true,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AdwButton(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
                if (onCancel != null) onCancel();
              },
            ),
            if (!hideConfirm)
              AdwButton.flat(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                onPressed: controller != null && controller.value.text.isEmpty
                    ? null
                    : onConfirm,
                child: Text("Ok"),
              ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
    required this.title,
    required this.padding,
  }) : super(key: key);

  final Widget child;
  final String title;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GtkDialog(
      title: Text(title, style: Theme.of(context).textTheme.headline5),
      padding: padding,
      actions: AdwActions(
        onClose: Navigator.of(context).pop,
        onHeaderDrag: appWindow?.startDragging,
        onDoubleTap: appWindow?.maximizeOrRestore,
      ),
      children: [
        child,
      ],
    );
  }
}
