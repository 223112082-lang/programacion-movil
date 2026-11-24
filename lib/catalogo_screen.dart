import 'package:flutter/material.dart';

import 'plant_card.dart';
import 'plant_details_screen.dart';
import 'plant_model.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalogo')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plantasDemo.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final planta = plantasDemo[index];
          return Hero(
            tag: 'planta-${planta.nombre}',
            child: PlantCard(
              nombre: planta.nombre,
              precio: planta.precio,
              rutaImagen: planta.rutaImagen,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDetailsScreen(
                      nombrePlanta: planta.nombre,
                      rutaImagen: planta.rutaImagen,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
