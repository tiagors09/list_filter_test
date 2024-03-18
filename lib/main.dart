import 'package:flutter/material.dart';
import 'package:list_filter_test/animal_kind.dart';
import 'package:list_filter_test/animal_list_card.dart';
import 'package:list_filter_test/animal_viewer.dart';

void main() {
  runApp(const MainApp());
}

class Animal {
  final String name;
  final int age;
  final AnimalKind animalKind;

  Animal({
    required this.name,
    required this.age,
    required this.animalKind,
  });
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final query = TextEditingController();
  int _selectedTile = -1;
  AnimalKind? _filter;
  bool _isAnimalSelected = false;
  int _selectedAnimal = -1;

  void _selectAnimalKind(int index) {
    setState(() {
      if ((_filter == null && _selectedTile == -1) ||
          (_filter != null && _selectedTile != index)) {
        _filter = AnimalKind.values[index];
        _selectedTile = index;
      } else {
        _filter = null;
        _selectedTile = -1;
      }
    });
  }

  void _backToHome() {
    setState(() {
      _isAnimalSelected = false;
      _selectedAnimal = -1;
    });
  }

  get _animals {
    return [
      Animal(name: 'Bob', age: 12, animalKind: AnimalKind.cat),
      Animal(name: 'Katly', age: 5, animalKind: AnimalKind.cat),
      Animal(name: 'Jeff', age: 5, animalKind: AnimalKind.dog),
      Animal(name: 'Shirley', age: 5, animalKind: AnimalKind.fish),
      Animal(name: 'Joana', age: 5, animalKind: AnimalKind.cat),
      Animal(name: 'Ketlen', age: 5, animalKind: AnimalKind.fish),
      Animal(name: 'Lory', age: 5, animalKind: AnimalKind.cat),
      Animal(name: 'Carl', age: 5, animalKind: AnimalKind.cat),
      Animal(name: 'Brian', age: 5, animalKind: AnimalKind.horse),
    ]
        .where((element) =>
            element.animalKind == _filter ||
            _filter == null ||
            query.value.toString().toLowerCase() == element.name.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width * 0.5;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(8.0),
          margin:
              EdgeInsets.fromLTRB(containerWidth / 2, 0, containerWidth / 2, 0),
          child: !_isAnimalSelected
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.075,
                      child: AnimalListCard(
                        selectedTile: _selectedTile,
                        onTap: _selectAnimalKind,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _animals.length,
                        itemBuilder: (ctx, index) => ListTile(
                          title: ListTile(
                            onTap: () {
                              setState(() {
                                _selectedAnimal = index;
                                _isAnimalSelected = true;
                              });
                            },
                            leading: Image.network(
                              'https://via.placeholder.com/150/92c952',
                            ),
                            title: Text(
                              _animals[index].name,
                            ),
                            subtitle: Text(
                              _animals[index].animalKind.label,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : AnimalViewer(
                  selectedAnimal: _animals[_selectedAnimal],
                  onPressed: _backToHome,
                ),
        ),
      ),
    );
  }
}
