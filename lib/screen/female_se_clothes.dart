import 'package:dress_up/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClothingSelectionFemaleScreen extends StatelessWidget {
  final List<ClothingCategory> clothingCategories = [
    const ClothingCategory(
      name: "Shirts",
      clothes: [
        ClothingItem(
            id: "shirt1",
            type: "shirt",
            texturePath: "assets/clothes/female/shirt1.png"),
      ],
    ),
    const ClothingCategory(
      name: "Pants",
      clothes: [
        ClothingItem(
            id: "pants1",
            type: "pants",
            texturePath: "assets/clothes/female/pants1.png"),
        ClothingItem(
            id: "skirt1",
            type: "pants",
            texturePath: "assets/clothes/female/skirt1.png"),
      ],
    ),
    const ClothingCategory(
      name: "Dresses",
      clothes: [
        ClothingItem(
            id: "dress1",
            type: "dress",
            texturePath: "assets/clothes/female/dress1.png"),
        ClothingItem(
            id: "dress2",
            type: "dress",
            texturePath: "assets/clothes/female/dress2.png"),
      ],
    ),
  ];

  ClothingSelectionFemaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Outfit"),
      ),
      body: ClothingSelectionBottomSheet(
        clothingCategories: clothingCategories,
      ),
    );
  }
}

class ClothingSelectionBottomSheet extends StatefulWidget {
  final List<ClothingCategory> clothingCategories;

  const ClothingSelectionBottomSheet({
    super.key,
    required this.clothingCategories,
  });

  @override
  _ClothingSelectionBottomSheetState createState() =>
      _ClothingSelectionBottomSheetState();
}

class _ClothingSelectionBottomSheetState
    extends State<ClothingSelectionBottomSheet> {
  ClothingItem? _selectedShirt;
  ClothingItem? _selectedPants;
  ClothingItem? _selectedDress;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var category in widget.clothingCategories)
              DropdownButtonFormField<ClothingItem>(
                value: category == widget.clothingCategories[0]
                    ? _selectedShirt
                    : category == widget.clothingCategories[1]
                        ? _selectedPants
                        : _selectedDress,
                onChanged: (value) {
                  setState(() {
                    if (category == widget.clothingCategories[0]) {
                      _selectedShirt = value;
                    } else if (category == widget.clothingCategories[1]) {
                      _selectedPants = value;
                    } else {
                      _selectedDress = value;
                    }
                  });
                },
                items: [
                  for (var item in category.clothes)
                    DropdownMenuItem(
                      value: item,
                      child: Row(
                        children: [
                          Image.asset(
                            item.texturePath,
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 10),
                          Text(item.id),
                        ],
                      ),
                    ),
                ],
                hint: Text("Select ${category.name}"),
              ),
            ElevatedButton(
              onPressed: () {
                try {
                  // Close the bottom sheet and pass the selected clothes
                  final selectedClothes = <String, ClothingItem>{};

                  if (_selectedShirt != null)
                    selectedClothes['shirt'] = _selectedShirt!;
                  if (_selectedPants != null)
                    selectedClothes['pants'] = _selectedPants!;
                  if (_selectedDress != null)
                    selectedClothes['dress'] = _selectedDress!;

                  if (selectedClothes.isNotEmpty) {
                    Navigator.pop(context, selectedClothes);
                  } else {
                    // Show a message to the user to select at least one item
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Please select at least one clothing item')),
                    );
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Error in onPressed: $e');
                  }
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
