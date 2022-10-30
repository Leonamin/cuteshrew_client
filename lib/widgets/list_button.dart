import 'package:cuteshrew/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ButtonProperties {
  int page;
  Color color;

  ButtonProperties({required this.page, this.color = Colors.black});
}

class ListButtonProperties {
  int id;
  Color color;
  VoidCallback onPressed;

  ListButtonProperties({
    required this.id,
    required this.color,
    required this.onPressed,
  });
}

class ListButton extends StatefulWidget {
  ListButton({
    super.key,
    required this.itemCount,
    this.backgroundColor,
    this.selectedColor,
    this.maxHeight,
    required this.propertyList,
    this.selectedIndex,
  });
  Color? backgroundColor;
  Color? selectedColor;
  double? maxHeight;
  int itemCount;
  List<ListButtonProperties> propertyList;
  int? selectedIndex = 0;

  @override
  State<ListButton> createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.propertyList
          .map((item) => CircleElevatedButton(
                color: item.id == widget.selectedIndex
                    ? widget.selectedColor ?? Colors.blue
                    : Colors.grey,
                onPressed: () {
                  setState(() {
                    widget.selectedIndex = item.id;
                  });
                  item.onPressed();
                },
                child: Text(item.id.toString()),
              ))
          .toList(),
    );
  }
}
