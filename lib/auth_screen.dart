import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_repository.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRepository _auth = AuthRepository();
  final TextEditingController _correoCtlr = TextEditingController();
  final TextEditingController _contrasenaCtlr = TextEditingController();

  bool esRegistro = false;
  bool cargando = false;
  String? error;

  @override
  void dispose() {
    _correoCtlr.dispose();
    _contrasenaCtlr.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    final correo = _correoCtlr.text.trim();
    final contrasena = _contrasenaCtlr.text;

    if (correo.isEmpty || contrasena.isEmpty) {
      setState(() => error = 'Correo y contraseña son requeridos');
      return;
    }

    setState(() {
      cargando = true;
      error = null;
    });

    try {
      if (esRegistro) {
        await _auth.registrar(correo, contrasena);
      } else {
        await _auth.iniciarSesion(correo, contrasena);
      }

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => error = AuthRepository.mensajeDeError(e));
      }
    } finally {
      if (mounted) {
        setState(() => cargando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset('img/flor2.png', width: 200, height: 200),
              const SizedBox(height: 24),
              TextField(
                controller: _correoCtlr,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electronico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contrasenaCtlr,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: cargando ? null : _enviar,
                  child: cargando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(esRegistro ? 'Registrarse' : 'Entrar'),
                ),
              ),
              TextButton(
                onPressed: cargando
                    ? null
                    : () {
                        setState(() => esRegistro = !esRegistro);
                      },
                child: Text(
                  esRegistro
                      ? '¿Ya tienes una cuenta? Iniciar sesión'
                      : '¿No tienes una cuenta? Registrarse',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
