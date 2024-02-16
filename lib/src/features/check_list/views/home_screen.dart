import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';
import 'package:jewelist/src/features/check_list/views/create_item_dialog.dart';
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
  // late List<Item> checkList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Get the latest items
  }

  void createNewItem() {
    // showAboutDialog(
    //   context: context,
    //   applicationName: 'Jewelist',
    //   applicationVersion: 'Wersion 0.1',
    //   applicationIcon: Expanded(
    //     child: Image.network(
    //         'https://res.cloudinary.com/unimemo-dfd94/image/upload/v1705308971/22487340_d7hjqv.jpg'),
    //   ),
    // );
    showDialog(
      context: context,
      builder: (context) {
        return CreateItemDialog(
          scrollController: _scrollController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChecklistState checkList = ref.watch(checklistControllerProvider);
    final List<Item> items = checkList.items;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Jewelist'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 1,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text('No items yet.'),
            )
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return ItemTile(
                  item: item,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewItem,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
