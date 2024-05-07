import 'package:flutter/material.dart';

class ToggleIconButton extends StatefulWidget {
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final Function(bool)? onChanged;

  const ToggleIconButton({
    Key? key,
    required this.icon,
    this.activeColor = Colors.pink,
    this.inactiveColor = Colors.grey,
    this.onChanged,
  }) : super(key: key);

  @override
  _ToggleIconButtonState createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isActive = !_isActive;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_isActive);
        }
      },
      icon: Icon(
        widget.icon,
        color: _isActive ? widget.activeColor : widget.inactiveColor,
      ),
    );
  }
}