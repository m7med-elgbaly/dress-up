import 'package:dress_up/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClothingSelectionScreen extends StatelessWidget {
  final List<ClothingCategory> clothingCategories = [
    const ClothingCategory(
      name: "Shirts",
      clothes: [
        ClothingItem(
            id: "shirt1",
            type: "shirt",
            texturePath: "assets/clothes/male/shirt1.png"),
        ClothingItem(
            id: "shirt2",
            type: "shirt",
            texturePath: "assets/clothes/male/shirt2.png"),
        ClothingItem(
            id: "shirt3",
            type: "shirt",
            texturePath: "assets/clothes/male/shirt3.png"),
      ],
    ),
    const ClothingCategory(
      name: "Pants",
      clothes: [
        ClothingItem(
            id: "pants1",
            type: "pants",
            texturePath: "assets/clothes/male/pants1.png"),
        ClothingItem(
            id: "pants2",
            type: "pants",
            texturePath: "assets/clothes/male/pants2.png"),
        ClothingItem(
            id: "pants3",
            type: "pants",
            texturePath: "assets/clothes/male/pants3.png"),
      ],
    ),
    // const ClothingCategory(
    //   name: "Shoes",
    //   clothes: [
    //     ClothingItem(
    //         id: "shoes1",
    //         type: "shoes",
    //         texturePath: "assets/images/shoes1.glb"),
    //     ClothingItem(
    //         id: "shoes2",
    //         type: "shoes",
    //         texturePath: "assets/images/shoes2.png"),
    //   ],
    // ),
  ];

  ClothingSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Outfit"),
      ),
      body: ClothingSelectionBottomSheet(
        clothingCategories: clothingCategories,
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       showModalBottomSheet(
      //         context: context,
      //         builder: (context) => ClothingSelectionBottomSheet(
      //           clothingCategories: clothingCategories,
      //         ),
      //       );
      //     },
      //     child: const Text("Select Clothes"),
      //   ),
      // ),
    );
  }
}

// Define the ClothingSelectionBottomSheet class
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
  ClothingItem? _selectedShoes;

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
                        : _selectedShoes,
                onChanged: (value) {
                  setState(() {
                    if (category == widget.clothingCategories[0]) {
                      _selectedShirt = value;
                    } else if (category == widget.clothingCategories[1]) {
                      _selectedPants = value;
                    } else {
                      _selectedShoes = value;
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
              child: Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
