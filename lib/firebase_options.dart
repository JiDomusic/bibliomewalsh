import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const String _apiKey = "AIzaSyAsNYZzSgic7F_7bChYxT62rITK9WVOpZU";
  static const String _authDomain = "biblio-me-walsh-f71b9.firebaseapp.com";
  static const String _databaseURL =
      "https://biblio-me-walsh-f71b9-default-rtdb.firebaseio.com";
  static const String _projectId = "biblio-me-walsh-f71b9";
  static const String _storageBucket =
      "biblio-me-walsh-f71b9.firebasestorage.app";
  static const String _messagingSenderId = "1016296727446";
  static const String _appId = "1:1016296727446:web:434cedb2a3a7664ea7b3b7";

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: _apiKey,
        authDomain: _authDomain,
        databaseURL: _databaseURL,
        projectId: _projectId,
        storageBucket: _storageBucket,
        messagingSenderId: _messagingSenderId,
        appId: _appId,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Agrega las opciones de configuración para Android aquí
      return FirebaseOptions(
        apiKey: _apiKey,
        authDomain: _authDomain,
        databaseURL: _databaseURL,
        projectId: _projectId,
        storageBucket: _storageBucket,
        messagingSenderId: _messagingSenderId,
        appId: _appId,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Agrega las opciones de configuración para iOS aquí
      return FirebaseOptions(
        apiKey: _apiKey,
        authDomain: _authDomain,
        databaseURL: _databaseURL,
        projectId: _projectId,
        storageBucket: _storageBucket,
        messagingSenderId: _messagingSenderId,
        appId: _appId,
      );
    } else {
      throw UnsupportedError('No se admite la plataforma actual.');
    }
  }
}
