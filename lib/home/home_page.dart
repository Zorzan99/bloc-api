import 'package:bloc_contact/home/widgets/button_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ButtonCard(
            onTap: () {
              Navigator.of(context).pushNamed('/bloc/example/');
            },
            text: 'Example',
          ),
          ButtonCard(
            onTap: () {
              Navigator.of(context).pushNamed('/bloc/example/freezed');
            },
            text: 'Example Freezed',
          ),
          ButtonCard(
            onTap: () {
              Navigator.of(context).pushNamed('/contacts/list');
            },
            text: 'Contact',
          ),
          ButtonCard(
            onTap: () {
              Navigator.of(context).pushNamed('/contacts/cubit/list');
            },
            text: 'Contact Cubit',
          ),
        ],
      ),
    );
  }
}
