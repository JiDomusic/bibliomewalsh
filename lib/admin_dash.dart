import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginUploadPage extends StatefulWidget {
  const LoginUploadPage({super.key});

  @override
  _LoginUploadPageState createState() => _LoginUploadPageState();
}

class _LoginUploadPageState extends State<LoginUploadPage> {
  // Controllers for login inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Controllers for content upload
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();

  String? _userRole; // Admin or User
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Authentication with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Fetch user role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      setState(() {
        _userRole = userDoc['role'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadContent() async {
    if (_image != null && _descriptionController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('images/admin_${DateTime.now()}.jpg');
        await storageRef.putFile(_image!);
        final imageUrl = await storageRef.getDownloadURL();

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('content').add({
          'description': _descriptionController.text,
          'imageUrl': imageUrl,
          'uploadedAt': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contenido subido con éxito')),
        );
        _descriptionController.clear();
        setState(() {
          _image = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al subir contenido: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildAdminPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image != null
            ? Image.file(_image!, height: 200)
            : const Placeholder(fallbackHeight: 200),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Seleccionar Imagen'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Descripción'),
          maxLines: 3,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _uploadContent,
          child: const Text('Subir Contenido'),
        ),
        const Divider(height: 30),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('content').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('No hay contenido subido aún.'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final content = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Image.network(content['imageUrl'], width: 50),
                    title: Text(content['description']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('content')
                            .doc(content.id)
                            .delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contenido eliminado.')),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Contenido')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userRole == null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'Correo electrónico'),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Contraseña'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Iniciar Sesión'),
                      ),
                    ],
                  ),
                )
              : _userRole == 'admin'
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildAdminPanel(),
                    )
                  : const Center(
                      child: Text(
                          'Bienvenido, usuario normal. Aquí iría el Dashboard.'),
                    ),
    );
  }
}
