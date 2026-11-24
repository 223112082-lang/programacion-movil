import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get cambiosDeSesion => _auth.authStateChanges();
  Future<void> registrar(String correo, String contrasena) async {
    await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
  }

  Future<void> iniciarSesion(String correo, String contrasena) async {
    await _auth.signInWithEmailAndPassword(email: correo, password: contrasena);
  }

  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  static String mensajeDeError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Este correo ya tiene una cuenta.';
      case 'invalid-email':
        return 'El correo que ingresaste no es válido.';
      case 'weak-password':
        return 'La contraseña es muy débil, debe tener mínimo 6 caracteres';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'network-request-failed':
        return 'Sin conexión. Intenta más tarde';
      case 'operation-not-allowed':
        return 'El inicio de sesión con correo y contraseña no está habilitado en Firebase.';
      case 'configuration-not-found':
        return 'Firebase Authentication no está configurado para este proyecto. En la consola de Firebase del proyecto fir-bc953, abre Authentication > Método de acceso y habilita Correo electrónico/Contraseña.';
      case 'user-disabled':
        return 'Esta cuenta está deshabilitada. Contacta al administrador.';
      case 'too-many-requests':
        return 'Se realizaron demasiados intentos. Espera un momento e inténtalo de nuevo.';
      default:
        return 'No se pudo iniciar sesión (código: ${e.code}).';
    }
  }
}
