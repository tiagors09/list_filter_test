import 'package:flutter/material.dart';
import 'package:list_filter_test/animal_kind.dart';

class AnimalListCard extends StatelessWidget {
  final void Function(int) onTap;
  final int selectedTile;

  const AnimalListCard({
    super.key,
    required this.onTap,
    required this.selectedTile,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: AnimalKind.values.length,
      itemBuilder: (ctx, index) => SizedBox(
        height: MediaQuery.of(ctx).size.height * 5,
        width: MediaQuery.of(ctx).size.width * 0.45,
        child: Card(
          elevation: 1,
          child: ListTile(
            selected: selectedTile == index ? true : false,
            title: Text(
              AnimalKind.values[index].toString().split('.')[1].toUpperCase(),
            ),
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}
