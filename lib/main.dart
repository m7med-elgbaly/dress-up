import 'package:dress_up/provider/pro.dart';
import 'package:dress_up/screen/avatar_s.dart';
import 'package:dress_up/screen/game_female_scr.dart';
import 'package:dress_up/screen/game_screen.dart';
import 'package:dress_up/screen/in_screen.dart';
import 'package:dress_up/screen/se_clothes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//             create: (context) => SelectedCharacterProvider()),
//         ChangeNotifierProvider(create: (context) => SelectedClothingProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dress Up Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CharacterSelectionScreen(),
//       routes: {
//         '/': (context) => CharacterSelectionScreen(),
//         '/second': (context) => const ClothingSelectionScreen(
//               characterType: "male",
//               clothingType: '',
//             ), // Adjust for initial character
//         '/threed': (context) => GameScreen(),
//       },
//     );
//   }
// }

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedAvatarProvider()),
        ChangeNotifierProvider(create: (_) => SelectedClothingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dress Up Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyWidget(),
        '/savatar': (context) => const CharacterSelectionScreen(),
        '/clothing': (context) => ClothingSelectionScreen(),
        '/femaleclothing': (context) =>
            ClothingSelectionScreen(), // Add clothing selection route
        '/femalegame': (context) => const GameFemaleScreen(),
        '/game': (context) => const GameScreen(),
        // '/dressedCharacters': (context) => const DressedCharactersScreen(), // Add new route
      },
    );
  }
}
