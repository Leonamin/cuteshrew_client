import 'package:cuteshrew/presentation/widgets/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NewListButton extends StatefulWidget {
  const NewListButton({
    super.key,
    this.itemCount,
    this.selectedIndex,
    this.selectedColor,
    this.unselectedColor,
    this.onPressed,
    this.children,
  });

  final int? itemCount;
  final int? selectedIndex;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Function(int index)? onPressed;
  final List<Widget>? children;

  @override
  State<NewListButton> createState() => _NewListButtonState();
}

class _NewListButtonState extends State<NewListButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount ?? 0,
        (index) => CircleElevatedButton(
          color: index == widget.selectedIndex
              ? widget.selectedColor ?? Theme.of(context).colorScheme.tertiary
              : widget.unselectedColor ??
                  Theme.of(context).colorScheme.onTertiary,
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed!(index);
            }
          },
          child: widget.children?[index],
        ),
      ),
    );
  }
}
