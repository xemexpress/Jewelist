import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/core/extensions.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';
import 'package:jewelist/src/features/check_list/widgets/item_field.dart';

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
            widget.scrollController.position.maxScrollExtent + 80,
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
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Create Item'),
          titlePadding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          backgroundColor: Theme.of(context).colorScheme.background,
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemField(
                  controller: _titleController,
                  currentFocusNode: _titleFocusNode,
                  onTap: () => setState(() {}),
                  onChanged: (value) {
                    final int offset = _titleController.selection.baseOffset;

                    setState(
                      () {
                        _titleError = false;
                        _titleController.text = value.capitalizeFirstofEach;

                        _titleController.selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: offset,
                          ),
                        );
                      },
                    );
                  },
                  onSubmitted: (value) => _quantityFocusNode.requestFocus(),
                  hasError: _titleError,
                  label: 'Title*',
                  errorLabel: 'Think of any title?',
                  hintText: 'Remember to take it',
                  errorHintText: 'Think of any?',
                  prefixIcon: Icons.inventory_2_outlined,
                  textCapitalization: TextCapitalization.words,
                ),
                ItemField(
                  controller: _quantityController,
                  currentFocusNode: _quantityFocusNode,
                  onTap: () => setState(() {}),
                  onSubmitted: (value) {
                    _descriptionFocusNode.requestFocus();
                  },
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
                  textCapitalization: TextCapitalization.sentences,
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
        ),
      ),
    );
  }
}
