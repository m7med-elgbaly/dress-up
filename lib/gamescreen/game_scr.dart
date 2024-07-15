import 'package:dress_up/gamescreen/clothesb.dart';
import 'package:dress_up/provider/3d_provider.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

import '3d_avatar.dart';
import '../models/3d_models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Avatar? _selectedAvatar;
  late Map<String, ClothingItem> _selectedClothing = {};
  List<Widget> _avatarClothingWidgets = [];

  @override
  Widget build(BuildContext context) {
    _selectedAvatar =
        Provider.of<SelectedAvatarProvider>(context).selectedAvatar;
    _selectedClothing =
        Provider.of<SelectedClothingProvider>(context).selectedClothing;
    putClothesOnAvatar();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Dressed Character"),
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: 2, // Two widgets: Avatar3D and SizedBox
          itemBuilder: (context, index) {
            if (index == 0) {
              // Render dressed avatar using Avatar3D widget
              return Avatar3D(
                avatar: _selectedAvatar!,
                avatarWidth: MediaQuery.of(context).size.width,
                avatarHeight: MediaQuery.of(context).size.height *
                    0.7, // Adjust height ratio as needed
              );
            } else {
              // Optional: Add a SizedBox for spacing
              return const SizedBox(height: 20.0);
            }
          },
        ),
        ..._avatarClothingWidgets,
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ClothingSelectionScreen(),
          ).then((selectedClothes) {
            if (selectedClothes != null) {
              // Update selected clothing based on user selection
              Provider.of<SelectedClothingProvider>(context, listen: false)
                  .setSelectedClothing(selectedClothes);

              // Put clothes on avatar
              putClothesOnAvatar();
            }
          });
        },
      ),
    );
  }

  void putClothesOnAvatar() {
    // Get the size of the avatar
    final Size avatarSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height * 0.7,
    );

    // Define proportions for each clothing item relative to the avatar's body parts
    final Map<String, double> clothingSizes = {
      'shirt': 0.3, // Shirt width relative to avatar width
      'pants': 0.4, // Pants width relative to avatar width
      'shoes': 0.15, // Shoes width relative to avatar width
    };

    final Map<String, double> clothingYOffsets = {
      'shirt': 0.05, // Shirt offset from top relative to avatar height
      'pants': 0.4, // Pants offset from top relative to avatar height
      'shoes': 0.75, // Shoes offset from top relative to avatar height
    };

    // Clear previous clothes
    setState(() {
      _avatarClothingWidgets.clear();
    });

    // Apply clothing sizes and positions to the avatar
    for (var entry in _selectedClothing.entries) {
      final String type = entry.key;
      final ClothingItem item = entry.value;

      // Calculate the size of the clothing item
      final double size = clothingSizes[type]! * avatarSize.width;

      // Calculate the position of the clothing item
      final double yOffset = clothingYOffsets[type]! * avatarSize.height;

      // Put the image of the clothes on the avatar
      final Widget clothingWidget = Positioned(
        left: (avatarSize.width - size) / 2,
        top: yOffset,
        child: SizedBox(
          height: size,
          width: size,
          child: ModelViewer(
            src: item.texturePath,
            autoRotate: false,
          ),
        ),
        // child: Image.asset(
        //   item.texturePath,
        //   width: size,
        //   height: size,
        //   fit: BoxFit.contain, // Ensure the clothing item fits within the specified size
        // ),
      );

      // Add the clothing widget to the list
      setState(() {
        _avatarClothingWidgets.add(clothingWidget);
      });
    }
  }
}
