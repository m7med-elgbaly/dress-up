// screens/character_selection_screen.dart
import 'package:dress_up/models/model.dart';
import 'package:dress_up/provider/pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterSelectionScreen extends StatelessWidget {
  const CharacterSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardAspectRatio =
        _calculateCardAspectRatio(screenWidth, screenHeight);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Character"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _calculateCrossAxisCount(screenWidth),
          childAspectRatio: cardAspectRatio,
        ),
        itemCount:
            Provider.of<SelectedAvatarProvider>(context).allAvatars.length,
        itemBuilder: (context, index) {
          final avatar =
              Provider.of<SelectedAvatarProvider>(context).allAvatars[index];
          return CharacterListItem(
            avatar: avatar,
          );
        },
      ),
    );
  }

  double _calculateCardAspectRatio(double screenWidth, double screenHeight) {
    return screenWidth / screenHeight;
  }

  int _calculateCrossAxisCount(double screenWidth) {
    if (screenWidth > 800) {
      return 4; // Adjust for medium/large screens
    } else if (screenWidth > 600) {
      return 3; // Adjust for smaller tablets
    } else if (screenWidth > 400) {
      return 2; // Adjust for smaller screens
    } else {
      return 1;
    }
  }
}

class CharacterListItem extends StatelessWidget {
  final Avatar avatar;
  const CharacterListItem({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth =
        (screenWidth - 3) / _calculateCrossAxisCount(screenWidth, screenHeight);

    return GestureDetector(
      onTap: () {
        Provider.of<SelectedAvatarProvider>(context, listen: false)
            .setSelectedAvatar(avatar);
        if (avatar.name == "Male") {
          Navigator.pushNamed(context, '/game');
        } else {
          Navigator.pushNamed(context, '/femalegame');
        }
      },
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    avatar.modelPath,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (avatar.name == 'Male')
                      const Icon(color: Colors.blueAccent, Icons.male),
                    if (avatar.name != 'Male')
                      const Icon(color: Colors.pinkAccent, Icons.female),
                    const SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Text(
                        avatar.name,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(double screenWidth, double screenHeight) {
    if (screenWidth > 800) {
      return 4; // Adjust for medium/large screens
    } else if (screenWidth > 600) {
      return 3; // Adjust for smaller tablets
    } else if (screenWidth > 400) {
      return 2; // Adjust for smaller screens
    } else {
      return 1;
    }
  }
}
