class Plant {
  final String id;
  final String nombre;
  final double precio;
  final String rutaImagen;
  final String categoria;

  const Plant({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categoria,
  });

  String get precioTexto => '\$${precio.toStringAsFixed(0)}';
  factory Plant.fromMap(String id, Map<String, dynamic> data) {
    return Plant(
      id: id,
      nombre: data['nombre'] as String? ?? 'sin nombre',
      precio: (data['precio'] as num?)?.toDouble() ?? 0,
      rutaImagen: data['rutaImagen'] as String? ?? '',
      categoria: data['categoria'] as String? ?? 'sin categoría',
    );
  }
}
