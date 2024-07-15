// ignore_for_file: library_private_types_in_public_api

import 'package:dress_up/models/model.dart';
import 'package:dress_up/provider/pro.dart';
import 'package:dress_up/screen/clothes_gri.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'se_clothes.dart';

// Assuming Avatar, ClothingItem, and SelectedAvatarProvider are defined elsewhere

// class GameScreen extends StatefulWidget {
//   const GameScreen({Key? key});

//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   late Avatar? _selectedAvatar;
//   late Map<String, ClothingItem> _selectedClothing = {};
//   final List<Widget> _avatarClothingWidgets = [];

//   @override
//   Widget build(BuildContext context) {
//     _selectedAvatar =
//         Provider.of<SelectedAvatarProvider>(context).selectedAvatar;
//     _selectedClothing =
//         Provider.of<SelectedClothingProvider>(context).selectedClothing;
//     putClothesOnAvatar();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Dressed Character"),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 maxHeight: MediaQuery.of(context).size.height * 0.7,
//               ),
//               child: Image.asset(
//                 _selectedAvatar!
//                     .modelPath, // Assuming imagePath is defined in Avatar class
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           ..._avatarClothingWidgets,
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) => ClothingSelectionScreen(),
//           ).then((selectedClothes) {
//             if (selectedClothes != null) {
//               // Update selected clothing based on user selection
//               Provider.of<SelectedClothingProvider>(context, listen: false)
//                   .setSelectedClothing(selectedClothes);

//               // Put clothes on avatar
//               putClothesOnAvatar();
//             }
//           });
//         },
//       ),
//     );
//   }

//   void putClothesOnAvatar() {
//     // Get the size of the avatar
//     final Size avatarSize = Size(
//       MediaQuery.of(context).size.width,
//       MediaQuery.of(context).size.height * 0.7,
//     );

//     // Define proportions for each clothing item relative to the avatar's body parts
//     final Map<String, double> clothingSizes = {
//       'shirt': 0.3, // Shirt width relative to avatar width
//       'pants': 0.4, // Pants width relative to avatar width
//       'shoes': 0.15, // Shoes width relative to avatar width
//     };

//     final Map<String, double> clothingYOffsets = {
//       'shirt': 0.05, // Shirt offset from top relative to avatar height
//       'pants': 0.4, // Pants offset from top relative to avatar height
//       'shoes': 0.75, // Shoes offset from top relative to avatar height
//     };

//     // Clear previous clothes
//     setState(() {
//       _avatarClothingWidgets.clear();
//     });

//     // Apply clothing sizes and positions to the avatar
//     for (var entry in _selectedClothing.entries) {
//       final String type = entry.key;
//       final ClothingItem item = entry.value;

//       // Calculate the size of the clothing item
//       final double size = clothingSizes[type]! * avatarSize.width;

//       // Calculate the position of the clothing item
//       final double yOffset = clothingYOffsets[type]! * avatarSize.height;

//       // Put the image of the clothes on the avatar
//       final Widget clothingWidget = Positioned(
//         left: (avatarSize.width - size) / 2,
//         top: yOffset,
//         child: Image.asset(
//           item.texturePath,
//           width: size,
//           fit: BoxFit
//               .contain, // Ensure the clothing item fits within the specified size
//         ),
//       );

//       // Add the clothing widget to the list
//       setState(() {
//         _avatarClothingWidgets.add(clothingWidget);
//       });
//     }
//   }
// }
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Avatar? _selectedAvatar;
  late Map<String, ClothingItem> _selectedClothing = {};

  @override
  Widget build(BuildContext context) {
    _selectedAvatar =
        Provider.of<SelectedAvatarProvider>(context).selectedAvatar!;
    _selectedClothing =
        Provider.of<SelectedClothingProvider>(context).selectedClothing;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Dressed Character"),
      ),
      body: AvatarPainter(
        avatarImagePath: _selectedAvatar!.modelPath,
        selectedClothing: _selectedClothing,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ClothingSelectionScreen(),
          ).then((selectedClothes) {
            if (selectedClothes != null) {
              Provider.of<SelectedClothingProvider>(context, listen: false)
                  .setSelectedClothing(selectedClothes);
              setState(() {
                try {
                  _selectedClothing = selectedClothes;
                } catch (e) {
                  if (kDebugMode) {
                    print('Error in onPressed: $e');
                  }
                }
              });
            }
          });
        },
      ),
    );
  }
}
