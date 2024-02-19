import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';
import 'package:jewelist/src/features/check_list/views/create_item_dialog.dart';
import 'package:jewelist/src/features/check_list/widgets/checklist_bottom_line.dart';
import 'package:jewelist/src/features/check_list/widgets/jewelist_drawer.dart';
import 'package:jewelist/src/features/check_list/widgets/widgets.dart';
import 'package:jewelist/src/models/models.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final EdgeInsets checklistPadding = const EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 20,
  );
  final double separatorHeight = 20.0;

  void createNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateItemDialog(
          scrollController: _scrollController,
        );
      },
    );
  }

  double getChecklistHeight(List<Item> items) {
    // Calculate the total height of all items including separators and padding
    const appBarHight = 115.0;
    const itemHeight = 68.0; // Fixed height for each item

    final double totalItemsHeight = appBarHight +
        items.length * itemHeight +
        (items.length - 1) * separatorHeight;

    return totalItemsHeight + checklistPadding.vertical;
  }

  bool checkShowBottomLine(List<Item> items) {
    // Get the checklist height
    final double checklistHeight = getChecklistHeight(items);

    // Get the screen height
    final double screenHeight = MediaQuery.of(context).size.height;
    return checklistHeight > screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    final checklist = ref.watch(checklistControllerProvider);
    final List<Item> items = checklist.items;

    // Determine if the bottom line should be shown
    final bool showBottomLine = checkShowBottomLine(items);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Jewelist'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
      ),
      drawer: const JewelistDrawer(),
      body: items.isEmpty
          ? const Center(
              child: Text('No items yet.'),
            )
          : ListView.separated(
              controller: _scrollController,
              padding: checklistPadding,
              separatorBuilder: (context, index) =>
                  SizedBox(height: separatorHeight),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length + (showBottomLine ? 1 : 0),
              itemBuilder: (context, index) {
                if (showBottomLine && index == items.length) {
                  return const ChecklistBottomLine();
                }

                final item = items[index];

                return ItemTile(item: item);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewItem,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
