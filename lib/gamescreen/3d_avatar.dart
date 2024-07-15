// ignore: file_names

import 'package:dress_up/provider/3d_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dress_up/models/3d_models.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

import 'avatarscr.dart';


// Define the Avatar3D class
class Avatar3D extends StatelessWidget {
  final Avatar avatar;
  final double avatarWidth;
  final double avatarHeight;

  const Avatar3D({
    super.key,
    required this.avatar,
    required this.avatarWidth,
    required this.avatarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadModel(),
      builder: (context, snapshot) {
        Provider.of<SelectedAvatarProvider>(context, listen: false)
            .setSelectedAvatar(avatar);
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!) {
            return SizedBox(
              width: avatarWidth,
              height: avatarHeight,
              child: ModelViewer(
                src: avatar.modelPath,
                alt: "Dressed 3D Avatar",
                cameraControls: true,
                autoRotate: false,
                ar: false,
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
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  Future<bool> _loadModel() async {
    try {
      await ModelLoader.loadModel(avatar.modelPath);
      return true;
    } catch (e) {
      // Handle error during model loading
      if (kDebugMode) {
        print("Error loading model: $e");
      }
      return false;
    }
  }
}



// widgets/score_display.dart (Optional)


