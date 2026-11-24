import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_repository.dart';
import 'auth_screen.dart';
import 'plant_details_screen.dart';
import 'catalogo_screen.dart';

import 'cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool esFavorito = false;

  void alternativoFavorito() {
    setState(() {
      esFavorito = !esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vivero+',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              final navigator = Navigator.of(context);
              await AuthRepository().cerrarSesion();
              if (!mounted) return;
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '🛒 ${context.watch<CartProvider>().cantidad}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 29, 198, 14),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 234, 111),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Image(
                      image: AssetImage('img/logo1.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenidos a Vivero+',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 70, 198, 11),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cuida tus plantas como cuidas tu mente',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 25, 210, 65),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AuthRepository().currentUser?.email ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: alternativoFavorito,
                icon: Icon(
                  esFavorito ? Icons.favorite : Icons.favorite_border,
                  color: esFavorito
                      ? const Color.fromARGB(255, 21, 192, 32)
                      : null,
                ),
                label: Text(
                  esFavorito ? 'En favoritos' : 'Agregar a favoritos',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().agregar();
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Agregar al carrito'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().quitar();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar del carrito'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatalogoScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Catálogo'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailsScreen(
                              nombrePlanta: 'Menta',
                              rutaImagen: 'img/28_menta.png',
                            ),
                          ),
                        );
                      },
                      child: _StatCard(
                        icon: Icons.local_florist,
                        label: '12 plantas',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.water_drop,
                      label: '3 por regar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 35, 192, 21)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 13, 161, 38),
            ),
          ),
        ],
      ),
    );
  }
}
