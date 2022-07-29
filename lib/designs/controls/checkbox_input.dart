import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void CaretMoved(Offset? globalCaretPosition);
typedef void Changed(bool? text);

// Helper widget to track caret position.
class CheckBoxInput extends StatefulWidget {
  final CaretMoved? onCaretMoved;
  final Changed? onChanged;
  final Widget? text;
  final EdgeInsetsGeometry contentPadding;
  final bool value;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;
  CheckBoxInput(
      {Key? key,
        this.onCaretMoved,
        this.onChanged,
        this.text,
        this.contentPadding=EdgeInsets.zero,
        this.value=false,
        this.activeColor,
        this.controlAffinity = ListTileControlAffinity.leading
      })
      : super(key: key);
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxInput> {
  final GlobalKey _fieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child:CheckboxListTile(
        title: widget.text,
        contentPadding:widget.contentPadding ,
        value:widget.value,
        activeColor: ( widget.activeColor!=null?widget.activeColor:Theme.of(context).colorScheme.primary),
        onChanged:widget.onChanged,
        controlAffinity: widget.controlAffinity,
      ),
    );
  }
}
