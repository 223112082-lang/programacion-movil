import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'plant_model.dart';
import 'core_theme.dart';
import 'cart_provider.dart';

class PlantDetailsScreen extends StatelessWidget {
  final Plant planta;

  const PlantDetailsScreen({required this.planta, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planta.nombre)),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Imagen de la planta
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),

                  child: Image.asset(
                    rutaImagen,
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Icono
              const Icon(
                Icons.local_florist,
                size: 50,
                color: Color(0xFF8D6E63),
              ),

              const SizedBox(height: 10),

              // Nombre de la planta
              Text(
                nombrePlanta,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().agregar();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$nombrePlanta agregada al carrito'),
                        ),
                      );
                    },

                    icon: const Icon(Icons.add_shopping_cart),

                    label: const Text('Agregar al carrito'),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().quitar();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$nombrePlanta eliminada del carrito'),
                        ),
                      );
                    },

                    icon: const Icon(Icons.delete),

                    label: const Text('Eliminar del carrito'),
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
