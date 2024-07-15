// screens/character_selection_screen.dart

import 'package:dress_up/models/3d_models.dart';
import 'package:dress_up/provider/3d_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

// class CharacterSelectionScreen extends StatelessWidget {
//   final List<Avatar> avatars = const [
//     Avatar(
//         id: "male_avatar",
//         name: "ذكر", // Name in Arabic
//         modelPath: "assets/avatar/male_avatar.glb"),
//     Avatar(
//         id: "female_avatar",
//         name: "أنثى", // Name in Arabic
//         modelPath: "assets/avatar/female_avatar.glb"),
//   ];
//
//   const CharacterSelectionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final high = MediaQuery.of(context).size.height;
//     final crossAxisCount = _calculateCrossAxisCount(screenWidth);
//     final cardAspectRatio = _calculateCardAspectRatio(screenWidth, context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("اختر شخصيتك"), // Title in Arabic
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Handle potential orientation changes (optional)
//           final isLandscape = constraints.maxWidth > constraints.maxHeight;
//
//           return SingleChildScrollView(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio: cardAspectRatio,
//                 // Adjust spacing based on screen size (optional)
//                 mainAxisSpacing: isLandscape ? 10.0 : 5.0,
//                 crossAxisSpacing: isLandscape ? 10.0 : 5.0,
//               ),
//               itemCount: avatars.length,
//               itemBuilder: (context, index) {
//                 final avatar = avatars[index];
//                 return GestureDetector(
//                   onTap: () =>
//                       Provider.of<SelectedAvatarProvider>(context, listen: false)
//                           .setSelectedAvatar(avatar),
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Wrap ModelViewer with SizedBox for defined size
//                           SizedBox(
//                             height: high / 280,
//                             child: FutureBuilder<bool>(
//                               future: ModelLoader.loadModel(avatar.modelPath), // Load model asynchronously
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData && snapshot.data!) {
//                                   // Model loaded successfully
//                                   return ModelViewer(
//                                     cameraControls: false,
//                                     src: avatar.modelPath,
//                                     ar: false, // Disable AR for simplicity
//                                     alt: "معاينة نموذج الشخصية ثلاثي الأبعاد", // Alt text in Arabic
//                                     autoRotate: true, // Allow user to rotate the model
//                                   );
//                                 } else if (snapshot.hasError) {
//                                   // Handle error (e.g., display error message)
//                                   print("خطأ في تحميل النموذج: ${snapshot.error}"); // Error message in Arabic
//                                   return const Center(
//                                     child: Text('خطأ في تحميل النموذج'), // Error text in Arabic
//                                   );
//                                 } else {
//                                   // Display a placeholder while loading
//                                   return const Center(child: CircularProgressIndicator());
//                                 }
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 10.0),
//                           // Use Flexible for flexible sizing of the Text widget
//                           Flexible(
//                             child: Text(
//                               avatar.name,
//                               style: const TextStyle(fontSize: 18.0),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   int _calculateCrossAxisCount(double screenWidth) {
//     if (screenWidth > 800) {
//       return 4; // Adjust for large screens (tablets)
//     } else if (screenWidth > 600) {
//       return 3; // Adjust for medium-sized screens (phones)
//     } else if (screenWidth > 400) {
//       return 2; // Adjust for smaller screens (phones)
//     } else {
//       return 1; // Single column for very small screens
//     }
//   }
//
//   double _calculateCardAspectRatio(double screenWidth, BuildContext context) {
//     return screenWidth / (isPortrait(context) ? 280.0 : 320.0); // Adjust for portrait/landscape
//   }
//
//   bool isPortrait(BuildContext context) {
//     return MediaQuery.of(context).orientation == Orientation.portrait;
//   }
// }
class ModelLoader {
  static Future<bool> loadModel(String modelPath) async {
    // Replace this with your actual model loading logic
    // (e.g., using a network call or reading from local storage)

    try {
      // Example: Loading from local storage (replace with your actual logic)
      final response = await rootBundle.load(modelPath);
      // Process the response (e.g., decode bytes) and return true on success
      return true;
    } catch (error) {
      print("Error loading model: $error");
      return false; // Indicate failure
    }
  }
}

class CharacterSelectionScreen extends StatelessWidget {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardAspectRatio = _calculateCardAspectRatio(screenWidth);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Character"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount:
            Provider.of<SelectedAvatarProvider>(context).allAvatars.length,
        itemBuilder: (context, index) {
          final avatar =
              Provider.of<SelectedAvatarProvider>(context).allAvatars[index];
          return CharacterListItem(
              avatar: avatar, cardAspectRatio: cardAspectRatio);
        },
      ),
    );
  }

  double _calculateCardAspectRatio(double screenWidth) {
    if (screenWidth > 600) {
      return 3.0; // Adjust for medium/large screens
    } else {
      return 2.0; // Adjust for smaller screens
    }
  }
}

class CharacterListItem extends StatelessWidget {
  final Avatar avatar;
  final double cardAspectRatio;

  const CharacterListItem(
      {super.key, required this.avatar, required this.cardAspectRatio});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<SelectedAvatarProvider>(context, listen: false)
            .setSelectedAvatar(avatar);
        Navigator.pushNamed(context, '/game');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: cardAspectRatio,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<bool>(
                  future: ModelLoader.loadModel(avatar.modelPath),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return Expanded(
                        child: ModelViewer(
                          src: avatar.modelPath,
                          ar: false, // Disable AR for simplicity
                          alt: "3D Avatar Preview",
                          autoRotate: true, // Enable auto-rotation (optional)
                          interactionPromptStyle: InteractionPromptStyle.basic,
                          // ... ModelViewer configuration from previous code ...
                        ),
                      );
                    } else if (snapshot.hasError) {
                      if (kDebugMode) {
                        print("Error loading model: ${snapshot.error}");
                      }
                      return const Center(
                        child: Text(
                          'Error loading model',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                Text(
                  avatar.name,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
