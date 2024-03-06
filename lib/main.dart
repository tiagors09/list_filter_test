import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

enum AnimalKind {
  dog,
  cat,
  fish,
  horse,
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
  int _selectedTile = -1;
  AnimalKind? _filter;

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
        .where((element) => element.animalKind == _filter || _filter == null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                child: LayoutBuilder(
                  builder: (_, cts) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AnimalKind.values.length,
                    itemBuilder: (_, index) => SizedBox(
                      height: cts.minHeight,
                      width: cts.maxWidth * 0.5,
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          selected: _selectedTile == index ? true : false,
                          title: Text(
                            AnimalKind.values[index]
                                .toString()
                                .split('.')[1]
                                .toUpperCase(),
                          ),
                          onTap: () => setState(() {
                            if ((_filter == null && _selectedTile == -1) ||
                                (_filter != null && _selectedTile != index)) {
                              _filter = AnimalKind.values[index];
                              _selectedTile = index;
                            } else {
                              _filter = null;
                              _selectedTile = -1;
                            }
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _animals.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text(
                      'Name: ${_animals[index].name}',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
