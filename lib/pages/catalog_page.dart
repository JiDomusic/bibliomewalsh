import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Map<String, String>> argentinos = List.generate(
    10,
    (index) => {
      'title': 'Libro Argentino ${index + 1}',
      'author': 'Autor Argentino ${index + 1}',
      'image': 'https://via.placeholder.com/150',
      'description': 'Descripción del Libro Argentino ${index + 1}',
    },
  );

  final List<Map<String, String>> argentinosEnIngles = List.generate(
    10,
    (index) => {
      'title': 'Libro Argentino en Inglés ${index + 1}',
      'author': 'Argentine Author ${index + 1}',
      'image': 'https://via.placeholder.com/150',
      'description': 'Description of Argentine Book in English ${index + 1}',
    },
  );

  final List<Map<String, String>> mundo = List.generate(
    10,
    (index) => {
      'title': 'Libro del Mundo ${index + 1}',
      'author': 'Autor del Mundo ${index + 1}',
      'image': 'https://via.placeholder.com/150',
      'description': 'Descripción del Libro del Mundo ${index + 1}',
    },
  );

  final List<Map<String, String>> mundoEnIngles = List.generate(
    10,
    (index) => {
      'title': 'World Book ${index + 1}',
      'author': 'World Author ${index + 1}',
      'image': 'https://via.placeholder.com/150',
      'description': 'Description of World Book ${index + 1}',
    },
  );

  final TextEditingController searchController = TextEditingController();
  String query = '';

  List<Map<String, String>> filterBooks(
      List<Map<String, String>> books, String query) {
    if (query.isEmpty) return books;
    return books.where((book) {
      final title = book['title']!.toLowerCase();
      final author = book['author']!.toLowerCase();
      return title.contains(query.toLowerCase()) ||
          author.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        centerTitle: true,
        backgroundColor: const Color(0xFF007A33),
      ),
      body: Container(
        color: const Color(0xFF009B4A),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar por título o autor',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildCategory(
                      'Autores Argentinos', filterBooks(argentinos, query)),
                  buildCategory('Autores Argentinos en Inglés',
                      filterBooks(argentinosEnIngles, query)),
                  buildCategory('Autores del Mundo', filterBooks(mundo, query)),
                  buildCategory('Autores del Mundo en Inglés',
                      filterBooks(mundoEnIngles, query)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: const Color(0xFF007A33),
        child: const Icon(Icons.home),
      ),
    );
  }

  Widget buildCategory(String title, List<Map<String, String>> books) {
    if (books.isEmpty) return const SizedBox();

    final ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              SizedBox(
                height: 250,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsPage(
                              title: book['title']!,
                              image: book['image']!,
                              description: book['description']!,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(book['image']!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                book['title']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                book['author']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Flecha izquierda
              Positioned(
                left: 0,
                top: 100,
                child: IconButton(
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset - 200,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
              // Flecha derecha
              Positioned(
                right: 0,
                top: 100,
                child: IconButton(
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset + 200,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const BookDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color(0xFF007A33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007A33),
              ),
              child: const Text('Volver al Catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}
