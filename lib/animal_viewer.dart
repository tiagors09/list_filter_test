import 'package:flutter/material.dart';
import 'package:list_filter_test/main.dart';

class AnimalViewer extends StatelessWidget {
  final Animal selectedAnimal;
  final void Function()? onPressed;

  const AnimalViewer({
    super.key,
    required this.selectedAnimal,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Column(
            children: [
              Image.network(
                'https://via.placeholder.com/600/92c952',
              ),
              Text(
                selectedAnimal.name,
              ),
              Text(
                selectedAnimal.animalKind.name,
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'voltar',
          ),
        )
      ],
    );
  }
}
