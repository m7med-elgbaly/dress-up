import 'package:dress_up/models/model.dart';
import 'package:flutter/foundation.dart';

class SelectedAvatarProvider extends ChangeNotifier {
  final List<Avatar> _avatars = const [
    Avatar(
      id: "male_avatar",
      name: "Male",
      modelPath: "assets/avatar/male_avatar.png",
    ),
    Avatar(
      id: "female_avatar",
      name: "Female",
      modelPath: "assets/avatar/female_avatar.png",
    ),
  ];
  Avatar? _selectedAvatar;

  List<Avatar> get allAvatars => List.unmodifiable(_avatars);

  Avatar? get selectedAvatar => _selectedAvatar;

  void setSelectedAvatar(Avatar avatar) {
    _selectedAvatar = avatar;
    notifyListeners();
  }
}

// Define the SelectedClothingProvider class
class SelectedClothingProvider extends ChangeNotifier {
  final Map<String, ClothingItem> _selectedClothing = {};

  Map<String, ClothingItem> get selectedClothing => _selectedClothing;

  void setSelectedClothing(Map<String, ClothingItem> clothes) {
    _selectedClothing.clear();
    _selectedClothing.addAll(clothes);
    notifyListeners();
  }
}
