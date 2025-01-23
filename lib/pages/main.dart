import 'package:flutter/material.dart';

import 'activities_page.dart';
import 'associate_page.dart';
import 'catalog_page.dart';
import 'contact_page.dart';
import 'history_page.dart ';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Virtual',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Library'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Fondo animado con rayas
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: StripePainter(_animation.value),
              );
            },
          ),
          // Contenido del home
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'biblio m.e. walsh',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar (llevar a un apartado del menú)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CatalogPage()),
                    );
                  },
                  child: const Text('Explorar el Catálogo'),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: const Text(
                'Menú Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Catálogo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Asociate'),
              onTap: () {
                // Navegar a la sección de Asociate
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssociatePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Actividades'),
              onTap: () {
                // Navegar a la sección de Actividades
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivitiesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Breve Historia'),
              onTap: () {
                // Navegar a la sección de Breve Historia
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contacto'),
              onTap: () {
                // Navegar a la sección de Contacto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AsociatePage {}

class StripePainter extends CustomPainter {
  final double progress;

  StripePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    // Dibujar rayas animadas
    for (int i = 2; i < size.height ~/ 50; i++) {
      paint.color = i.isNegative
          ? Colors.green.withOpacity(0.2 * progress)
          : Colors.orange.withOpacity(0.3 + (0.1 * progress));
      canvas.drawRect(
        Rect.fromLTWH(0, i * 80.0 * progress, size.width, 100),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
