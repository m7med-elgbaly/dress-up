import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      'ا.د/وفاء محمد محمد عبد الرحمن سماحة',
      'أ.د / أميره عبدالله نور الدين المهدي',
      'م / شيرين جمال محمد السيد عبده',
      'م / حنان طاهر طاهر الخريبي'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dressed App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          //  body: Padding(
          // child: Card(
          //   elevation: 5.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Card(
                    shadowColor: const Color.fromARGB(85, 90, 89, 89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 10,
                    color: const Color.fromARGB(55, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          names[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.amiri(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            },
          ),
        ),
      ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/savatar'),
        child: const Icon(Icons.arrow_right_alt_outlined),
      ),
    );
  }

  double _calculateCardAspectRatio(double screenWidth, double screenHeight) {
    return screenWidth / (screenHeight / 4); // Adjusted for better card size
  }

  int _calculateCrossAxisCount(double screenWidth) {
    if (screenWidth > 800) {
      return 4; // Adjust for medium/large screens
    } else if (screenWidth > 600) {
      return 3; // Adjust for smaller tablets
    } else if (screenWidth > 400) {
      return 2; // Adjust for smaller screens
    } else {
      return 1; // Adjust for very small screens
    }
  }
}
