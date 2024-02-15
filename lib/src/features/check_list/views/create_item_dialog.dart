import 'package:flutter/material.dart';
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
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              onSubmitted: (value) => _quantityFocusNode.requestFocus(),
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Title'),
                hintText: 'Remember to take it',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.inventory_2_outlined),
                ),
                prefixIconConstraints: BoxConstraints.tightForFinite(),
              ),
            ),
            TextField(
              controller: _quantityController,
              focusNode: _quantityFocusNode,
              onSubmitted: (value) => _descriptionFocusNode.requestFocus(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Quantity'),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: 'Enter here',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.label_outline),
                ),
                prefixIconConstraints: BoxConstraints.tightForFinite(),
              ),
            ),
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              maxLines: 3,
              onSubmitted: (_) => saveNewItem(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Description'),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                prefixIcon: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
                      child: Icon(Icons.description_outlined),
                    ),
                  ],
                ),
                prefixIconConstraints: BoxConstraints(minHeight: 79),
                hintText: 'Enter here',
                alignLabelWithHint: true,
              ),
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
