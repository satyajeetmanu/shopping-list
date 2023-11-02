import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final _groceryList = [];

  void _addItem() async {
    final newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    ));

    if (newItem == null) {
      return;
    } else {
      setState(() {
        _groceryList.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        const Center(child: Text('List is empty.. try adding some items!'));

    if (_groceryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryList.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryList[index].id),
          onDismissed: (direction) {
            final currentItem = _groceryList[index];
            setState(() {
              _groceryList.removeAt(index);
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Item deleted'),
                action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        _groceryList.insert(index, currentItem);
                      });
                    }),
              ),
            );
          },
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(_groceryList[index].name),
            leading: Container(
              height: 24,
              width: 24,
              color: _groceryList[index].category.color,
            ),
            trailing: Text(_groceryList[index].quantity.toString()),
          ),
        ),
      );
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Grocery List'),
        ),
        body: content);
  }
}
