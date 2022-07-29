import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'input_helper.dart';

typedef void CaretMoved(Offset? globalCaretPosition);
typedef void TextChanged(String text);
// Helper widget to track caret position.
class IconTextInput extends StatefulWidget {
  final TextEditingController controller;
  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;
  final String? label;
  final bool isObscured;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final int maxLines;
  IconTextInput(
      {Key? key,
        this.onCaretMoved,
        this.onTextChanged,
        required this.controller,
        this.hint,
        this.label,
        this.prefixIcon,
        this.isObscured = false,
        this.validator,
        this.maxLines=1
      })
      : super(key: key);
  @override
  _IconTextInputState createState() => _IconTextInputState();
}

class _IconTextInputState extends State<IconTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  Timer? _debounceTimer;
  @override
  initState() {
    widget.controller.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          final RenderObject? fieldBox =
          _fieldKey.currentContext?.findRenderObject();
          var caretPosition = fieldBox is RenderBox ? getCaretPosition(fieldBox) : null;
          widget.onCaretMoved?.call(caretPosition);
        }
      });
      widget.onTextChanged?.call(widget.controller.text);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child:  TextFormField(
        key: _fieldKey,
        controller:widget.controller,
        obscureText: widget.isObscured,
        validator:widget.validator,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            prefixIcon:widget.prefixIcon,
            hintText: widget.hint,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );
  }
}
