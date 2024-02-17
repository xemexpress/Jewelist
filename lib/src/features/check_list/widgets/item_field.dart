import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemField extends StatelessWidget {
  const ItemField({
    super.key,
    required this.controller,
    required this.currentFocusNode,
    required this.onTap,
    required this.onSubmitted,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.digitOnly = false,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.hasError,
    this.errorLabel,
    this.errorHintText,
  });

  final TextEditingController controller;
  final FocusNode currentFocusNode;
  final void Function() onTap;
  final void Function(String) onSubmitted;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool digitOnly;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final bool? hasError;
  final String? errorLabel;
  final String? errorHintText;

  bool get isMultiLine => maxLines > 1;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(label),
      onTap: onTap,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: hasError != null &&
                errorLabel != null &&
                hasError! &&
                !currentFocusNode.hasFocus
            ? Text(
                errorLabel!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            : Text(label),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: isMultiLine ? 14 : 8,
        ),
        hintText: hasError != null && errorHintText != null && hasError!
            ? errorHintText
            : hintText,
        hintStyle: TextStyle(
          color: hasError != null && hasError!
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onBackground,
        ),
        prefixIcon: isMultiLine
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    child: Icon(prefixIcon),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(prefixIcon),
              ),
        prefixIconConstraints: isMultiLine
            ? const BoxConstraints(minHeight: 79)
            : const BoxConstraints.tightForFinite(),
        alignLabelWithHint: true,
      ),
      controller: controller,
      focusNode: currentFocusNode,
      keyboardType: digitOnly ? TextInputType.number : TextInputType.text,
      inputFormatters:
          digitOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      maxLines: maxLines,
      textInputAction: TextInputAction.done,
      textCapitalization: textCapitalization,
      autocorrect: false,
    );
  }
}
