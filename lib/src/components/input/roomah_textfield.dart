import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';

class RoomahTextField extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final bool obsecureText;
  final bool enabled;
  final bool isAlphabetOnly;
  final bool isCurrency;
  final bool selection;
  final String? errorMessage;
  final TextEditingController? controller;
  final Function(String? val) onChanged;
  final Icon? trailingIcon;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool showLengthIndicator;
  final String? semanticLabel;

  const RoomahTextField(this.label,
      {super.key,
      this.inputType = TextInputType.text,
      this.obsecureText = false,
      this.selection = false,
      this.enabled = true,
      this.isAlphabetOnly = false,
      this.isCurrency = false,
      this.errorMessage,
      this.controller,
      this.trailingIcon,
      this.minLines = 1,
      this.maxLines = 1,
      this.maxLength,
      this.showLengthIndicator = true,
      this.semanticLabel,
      required this.onChanged});

  @override
  State<RoomahTextField> createState() => _RoomahTextFieldState();
}

class _RoomahTextFieldState extends State<RoomahTextField> {
  final FocusNode _focusNode = FocusNode();
  int maxLines = 1;
  int enteredCharacted = 0;

  var inputFormatters = <TextInputFormatter>[];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => {});
    });

    maxLines = widget.maxLines;
    if (widget.minLines > widget.maxLines) {
      maxLines = widget.minLines;
    }
  }

  bool isError() {
    if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool hasMaxLength() {
    if (widget.maxLength != null && widget.maxLength! > 0) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAlphabetOnly) {
      inputFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")));
    }
    if (widget.isCurrency) {
      inputFormatters.add(
        CurrencyInputFormatter(
          leadingSymbol: 'Rp',
          useSymbolPadding: false,
          thousandSeparator: ThousandSeparator.Period,
          mantissaLength: 0,
        ),
      );
    }
    if (hasMaxLength()) {
      inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          decoration: BoxDecoration(
            border: Border.all(
                color: isError()
                    ? Colors.red
                    : _focusNode.hasFocus
                        ? RoomahColors.primary
                        : RoomahColors.primaryAccent,
                width: 1),
            borderRadius: BorderRadius.circular(8),
            color: widget.enabled == true
                ? Colors.white
                : RoomahColors.textSecondary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Semantics(
                      label: widget.semanticLabel ?? '',
                      child: TextFormField(
                        controller: widget.controller,
                        onChanged: (value) {
                          widget.onChanged(value);
                          setState(() {
                            enteredCharacted = value.length;
                          });
                        },
                        inputFormatters: inputFormatters,
                        autofocus: false,
                        minLines: widget.minLines,
                        maxLines: maxLines,
                        enabled:
                            widget.selection == true ? false : widget.enabled,
                        focusNode: _focusNode,
                        keyboardType: widget.inputType,
                        obscureText: widget.obsecureText,
                        style: RoomahTextStyle.labelMedium,
                        cursorColor: RoomahColors.primary,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.info_outline_rounded,
                            semanticLabel: 'icon_warning',
                            color: isError() ? Colors.red : Colors.transparent,
                          ),
                          contentPadding: const EdgeInsets.only(top: 6),
                          border: InputBorder.none,
                          labelText: widget.label,
                          labelStyle: RoomahTextStyle.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  if (widget.trailingIcon != null)
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        widget.trailingIcon!,
                        const SizedBox(width: 16),
                      ],
                    )
                ],
              ),
            ],
          ),
        ),
        if (isError() || hasMaxLength())
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isError()
                  ? Text(
                      isError() ? widget.errorMessage! : '',
                      semanticsLabel: 'text_errorMessage',
                      style: RoomahTextStyle.labelSmall,
                    )
                  : const SizedBox(),
              if (hasMaxLength() && widget.showLengthIndicator)
                Text(
                  '$enteredCharacted / ${widget.maxLength}',
                  style: RoomahTextStyle.labelSmall,
                ),
            ],
          ),
      ],
    );
  }
}
