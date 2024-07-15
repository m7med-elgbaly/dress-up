import 'package:dress_up/models/model.dart';
import 'package:dress_up/provider/pro.dart';
import 'package:dress_up/screen/female_avatar_painter.dart';
import 'package:dress_up/screen/female_se_clothes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameFemaleScreen extends StatefulWidget {
  const GameFemaleScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameFemaleScreen> {
  late Avatar? _selectedAvatar;
  late Map<String, ClothingItem> _selectedClothing;

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
      body: AvatarFemalePainter(
        avatarImagePath: _selectedAvatar!.modelPath,
        selectedClothing: _selectedClothing,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ClothingSelectionFemaleScreen(),
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
