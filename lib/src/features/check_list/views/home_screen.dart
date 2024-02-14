import 'package:flutter/material.dart';
import 'package:jewelist/src/features/check_list/widgets/widgets.dart';
import 'package:jewelist/src/models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> checkList = [];

  @override
  void initState() {
    super.initState();
    // Get the latest items
  }

  void onChecked(int index) {
    setState(() {
      checkList[index].isChecked = !checkList[index].isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Jewelist'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: checkList.length,
        itemBuilder: (context, index) {
          final item = checkList[index];

          return ItemTile(
            item: item,
            onChecked: (value) => onChecked(index),
          );
        },
      ),
    );
  }
}
