import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (value) {
                return 'demo...';
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: '1',
                    decoration: const InputDecoration(label: Text('Quantity')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField(
                    items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6),
                              Text(category.value.title),
                            ],
                          ),
                        )
                    ],
                    onChanged: (value) {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Reset')),
                const SizedBox(width: 4),
                ElevatedButton(onPressed: () {}, child: const Text('Save Item'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
