import 'package:dress_up/models/model.dart';
import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' show Vector2, Vector3;

// class AvatarPainter extends StatelessWidget {
//   final String avatarImagePath;
//   final Map<String, ClothingItem> selectedClothing;

//   const AvatarPainter({
//     super.key,
//     required this.avatarImagePath,
//     required this.selectedClothing,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double avatarWidth = constraints.maxWidth;
//         final double avatarHeight = constraints.maxHeight * 0.7;

//         return SingleChildScrollView(
//           child: Stack(
//             children: [
//               Image.asset(
//                 avatarImagePath,
//                 fit: BoxFit.contain,
//                 width: avatarWidth,
//                 height: avatarHeight,
//               ),
//               ...selectedClothing.entries.map((entry) {
//                 final String type = entry.key;
//                 final ClothingItem item = entry.value;
//                 final Vector2 size =
//                     _calculateClothingSize(type, avatarWidth, avatarHeight);
//                 final Vector3 position =
//                     _calculateClothingPosition(type, avatarWidth, avatarHeight);
//                 return Positioned(
//                   left: position.x,
//                   top: position.y,
//                   child: Image.asset(
//                     item.texturePath,
//                     width: size.x,
//                     height: size.y,
//                     fit: BoxFit.contain,
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Vector2 _calculateClothingSize(
//       String type, double avatarWidth, double avatarHeight) {
//     final Map<String, double> clothingWidthRatios = {
//       'shirt': 0.4, // Shirt width relative to avatar width
//       'pants': 0.3, // Pants width relative to avatar width
//     };
//     final clothingWidthRatio = clothingWidthRatios[type] ?? 0.26;
//     return Vector2(
//       clothingWidthRatio * avatarWidth,
//       clothingWidthRatio * avatarHeight,
//     );
//   }

//   Vector3 _calculateClothingPosition(
//       String type, double avatarWidth, double avatarHeight) {
//     final Map<String, double> clothingYOffsets = {
//       'shirt': 0.14, // Shirt offset from top relative to avatar height
//       'pants': 0.3, // Pants offset from top relative to avatar height
//     };
//     final Map<String, double> clothingXOffsets = {
//       'shirt': 0.35, // Shirt offset from left relative to avatar width
//       'pants': 0.289, // Pants offset from left relative to avatar width
//     };

//     final clothingYOffset = clothingYOffsets[type] ?? 0.12;
//     final clothingXOffset = clothingXOffsets[type] ?? 0.398;

//     return Vector3(
//       avatarWidth * clothingXOffset,
//       avatarHeight * clothingYOffset,
//       0,
//     );
//   }
// }
class AvatarPainter extends StatelessWidget {
  final String avatarImagePath;
  final Map<String, ClothingItem> selectedClothing;

  const AvatarPainter({
    super.key,
    required this.avatarImagePath,
    required this.selectedClothing,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarWidth = MediaQuery.of(context).size.width;
    final double avatarHeight = MediaQuery.of(context).size.height * 0.65;

    return Scaffold(
      body: Stack(
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
            final Vector2 size =
                _calculateClothingSize(type, avatarWidth, avatarHeight);
            final Vector3 position =
                _calculateClothingPosition(type, avatarWidth, avatarHeight);
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
      ),
    );
  }

  Vector2 _calculateClothingSize(
      String type, double avatarWidth, double avatarHeight) {
    final Map<String, double> clothingWidthRatios = {
      'shirt': 1, // Shirt width relative to avatar width
      'pants': 1, // Pants width relative to avatar width
    };
    final clothingWidthRatio = clothingWidthRatios[type] ?? 0.26;
    return Vector2(
      clothingWidthRatio * avatarWidth,
      clothingWidthRatio * avatarHeight,
    );
  }

  Vector3 _calculateClothingPosition(
      String type, double avatarWidth, double avatarHeight) {
    final Map<String, double> clothingYOffsets = {
      'shirt': -0, // Shirt offset from top relative to avatar height
      'pants': 0, // Pants offset from top relative to avatar height
    };
    final Map<String, double> clothingXOffsets = {
      'shirt': 0, // Shirt offset from left relative to avatar width
      'pants': 0, // Pants offset from left relative to avatar width
    };

    final clothingYOffset = clothingYOffsets[type] ?? 0.12;
    final clothingXOffset = clothingXOffsets[type] ?? 0.378;

    return Vector3(
      clothingXOffset * avatarWidth,
      clothingYOffset * avatarHeight,
      0,
    );
  }
}
