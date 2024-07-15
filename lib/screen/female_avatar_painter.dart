import 'package:dress_up/models/model.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class AvatarFemalePainter extends StatelessWidget {
  final String avatarImagePath;
  final Map<String, ClothingItem> selectedClothing;

  const AvatarFemalePainter(
      {super.key,
      required this.avatarImagePath,
      required this.selectedClothing});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double avatarWidth = constraints.maxWidth;
        final double avatarHeight = constraints.maxHeight * 0.7;

        return Stack(
          children: [
            Image.asset(
              avatarImagePath,
              fit: BoxFit.contain,
              width: avatarWidth,
              height: avatarHeight,
            ),
            ...selectedClothing.entries.map((entry) {
              final String type = entry.key;
              final ClothingItem item = entry.value;
              final Vector2 size = _calculateClothingSize(
                  context, type, avatarWidth, avatarHeight);
              final Vector3 position = _calculateClothingPosition(
                  context, type, avatarWidth, avatarHeight);
              return Positioned(
                left: position.x,
                top: position.y,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(0)
                    ..rotateY(0)
                    ..rotateZ(0),
                  child: Image.asset(
                    item.texturePath,
                    width: size.x,
                    height: size.y,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Vector2 _calculateClothingSize(BuildContext context, String type,
      double avatarWidth, double avatarHeight) {
    final Map<String, double> clothingWidthRatios = {
      'shirt': 1, // Shirt width relative to avatar width
      'pants': 1, // Pants width relative to avatar width
      'dress': 1, // Dress width relative to avatar width
    };
    final clothingWidthRatio = clothingWidthRatios[type] ?? 0.26;
    return Vector2(
      clothingWidthRatio * avatarWidth,
      clothingWidthRatio * avatarHeight,
    );
  }

  Vector3 _calculateClothingPosition(BuildContext context, String type,
      double avatarWidth, double avatarHeight) {
    final Map<String, double> clothingYOffsets = {
      'shirt': 0, // Shirt offset from top relative to avatar height
      'pants': 0, // Pants offset from top relative to avatar height
      'dress': 0, // Dress offset from top relative to avatar height
    };
    final Map<String, double> clothingXOffsets = {
      'shirt': 0, // Shirt offset from left relative to avatar width
      'pants': 0, // Pants offset from left relative to avatar width
      'dress': 0, // Dress offset from left relative to avatar width
    };

    final clothingYOffset = clothingYOffsets[type] ?? 0.12;
    final clothingXOffset = clothingXOffsets[type] ?? 0.378;

    return Vector3(
      avatarWidth * clothingXOffset,
      avatarHeight * clothingYOffset,
      0,
    );
  }
}
