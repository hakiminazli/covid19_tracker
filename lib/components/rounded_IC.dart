import 'package:flutter/material.dart';
import 'package:covid19_tracker/components/text_field_container.dart';
import 'package:covid19_tracker/constants.dart';

class RoundedIC extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedIC({
    Key key,
    this.hintText,
    this.icon = Icons.perm_identity_rounded,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
