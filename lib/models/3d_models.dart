// models/avatar.dart

class Avatar {
  final String id;
  final String name;
  final String modelPath; // Path to the 3D model (GLB)

  const Avatar({required this.id, required this.name, required this.modelPath});
}

// models/clothing_item.dart

class ClothingItem {
  final String id;
  final String type; // "shirt", "pants", "shoes"
  final String texturePath; // Path to the clothing texture image (PNG)

  const ClothingItem(
      {required this.id, required this.type, required this.texturePath});
}
class ClothingCategory {
  final String name;
  final List<ClothingItem> clothes;

  const ClothingCategory({required this.name, required this.clothes});
}