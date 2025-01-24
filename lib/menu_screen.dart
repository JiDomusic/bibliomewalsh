import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú de la Biblioteca')),
      body: ListView(
        children: List.generate(5, (index) {
          return ListTile(
            title: Text('Sección ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      adminDash(section: 'Sección ${index + 1}'),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  adminDash({required String section}) {}
}
