import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';

class CreateItemDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const CreateItemDialog({
    super.key,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateItemDialogState();
}

class _CreateItemDialogState extends ConsumerState<CreateItemDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _titleFocusNode = FocusNode();
  final _quantityFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  bool _titleError = false;

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();

    _titleFocusNode.dispose();
    _quantityFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  void saveNewItem() {
    if (_titleController.text.isEmpty) {
      setState(() {
        _titleError = true;
      });
      _titleFocusNode.requestFocus();
      return;
    } else {
      setState(() {
        _titleError = false;
      });
    }

    final int quantity = int.parse(
      _quantityController.text.isNotEmpty ? _quantityController.text : '0',
    );

    ref.read(checklistControllerProvider.notifier).createItem(
          title: _titleController.text,
          quantity: quantity,
          description: _descriptionController.text,
          context: context,
        );

    clearInputs();

    _titleFocusNode.requestFocus();

    // After adding the item, scroll to the bottom of the list
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.scrollController.hasClients) {
          widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  void clearInputs() {
    _titleController.clear();
    _quantityController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Item'),
      titlePadding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: SizedBox(
        // height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ItemField(
            //   controller: _titleController,
            //   currentFocusNode: _titleFocusNode,
            //   onTap: () => setState(() {}),
            //   onChanged: (value) => setState(() {
            //     _titleError = false;
            //   }),
            //   onSubmitted: (value) => _quantityFocusNode.requestFocus(),
            //   label: 'Title',
            //   hintText: 'Remember to take it',
            //   prefixIcon: Icons.inventory_2_outlined,
            //   textCapitalization: TextCapitalization.words,

            // ),
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              onTap: () => setState(() {}),
              onChanged: (value) => setState(() {
                _titleError = false;
              }),
              autocorrect: false,
              onSubmitted: (value) => _quantityFocusNode.requestFocus(),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: _titleError && !_titleFocusNode.hasFocus
                    ? Text(
                        'Think of any title?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      )
                    : const Text('Title'),
                // label: const Text('Title'),
                hintText: _titleError ? 'Think of any?' : 'Remember to take it',
                hintStyle: TextStyle(
                  color: _titleError
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onBackground,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.inventory_2_outlined),
                ),
                prefixIconConstraints: const BoxConstraints.tightForFinite(),
              ),
            ),
            ItemField(
              controller: _quantityController,
              currentFocusNode: _quantityFocusNode,
              onTap: () => setState(() {}),
              onSubmitted: (value) => _descriptionFocusNode.requestFocus(),
              label: 'Quantity',
              hintText: 'Enter here',
              prefixIcon: Icons.label_outline,
              digitOnly: true,
            ),
            ItemField(
              controller: _descriptionController,
              currentFocusNode: _descriptionFocusNode,
              onTap: () => setState(() {}),
              onSubmitted: (_) => saveNewItem(),
              label: 'Description',
              hintText: 'Enter here',
              prefixIcon: Icons.description_outlined,
              maxLines: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: clearInputs,
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: saveNewItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Mark',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
  final void Function(String)? onChanged;
  final TextCapitalization textCapitalization;

  bool get isMultiLine => maxLines > 1;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: isMultiLine ? 14 : 8,
        ),
        hintText: hintText,
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
      keyboardType: !digitOnly ? TextInputType.number : null,
      inputFormatters:
          !digitOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
      maxLines: maxLines,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
    );
  }
}
