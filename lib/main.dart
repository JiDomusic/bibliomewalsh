import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart'; // Asegúrate de tener este archivo configurado con Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), // Cambiar a MyHomePage para usar el Drawer
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase Web"),
        centerTitle: true, // Centra el título en el AppBar
        backgroundColor: Colors.red, // Fondo del AppBar en rojo
      ),
      drawer: Drawer(
        // Agregar el Drawer (Menú)
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Sección 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Seccion1()),
                );
              },
            ),
            ListTile(
              title: Text('Sección 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Seccion2()),
                );
              },
            ),
            ListTile(
              title: Text('Sección 3'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Seccion3()),
                );
              },
            ),
            ListTile(
              title: Text('Sección 4'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Seccion4()),
                );
              },
            ),
            ListTile(
              title: Text('Sección 5'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Seccion5()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Firebase Initialized!",
          style: TextStyle(fontSize: 24),
        ),
      ),
      backgroundColor: Colors.pinkAccent, // Fondo general en rosa
    );
  }
}

// Pantalla Sección 1
class Seccion1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección 1"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200, // Ajusta el tamaño de la imagen
                  width: double.infinity,
                  color: Colors.grey[300], // Color de fondo para la imagen
                  child: Center(
                    child: Text(
                      'Imagen de Sección 1',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Contenido de la Sección 1",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text("Aquí puedes agregar más detalles de esta sección."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla Sección 2
class Seccion2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección 2"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200, // Ajusta el tamaño de la imagen
                  width: double.infinity,
                  color: Colors.grey[300], // Color de fondo para la imagen
                  child: Center(
                    child: Text(
                      'Imagen de Sección 2',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Contenido de la Sección 2",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text("Aquí puedes agregar más detalles de esta sección."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla Sección 3
class Seccion3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección 3"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200, // Ajusta el tamaño de la imagen
                  width: double.infinity,
                  color: Colors.grey[300], // Color de fondo para la imagen
                  child: Center(
                    child: Text(
                      'Imagen de Sección 3',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Contenido de la Sección 3",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text("Aquí puedes agregar más detalles de esta sección."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla Sección 4
class Seccion4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección 4"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200, // Ajusta el tamaño de la imagen
                  width: double.infinity,
                  color: Colors.grey[300], // Color de fondo para la imagen
                  child: Center(
                    child: Text(
                      'Imagen de Sección 4',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Contenido de la Sección 4",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text("Aquí puedes agregar más detalles de esta sección."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla Sección 5
class Seccion5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección 5"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200, // Ajusta el tamaño de la imagen
                  width: double.infinity,
                  color: Colors.grey[300], // Color de fondo para la imagen
                  child: Center(
                    child: Text(
                      'Imagen de Sección 5',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Contenido de la Sección 5",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Text("Aquí puedes agregar más detalles de esta sección."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
