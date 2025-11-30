import 'package:flutter/material.dart';

class ClavierPersonnalise extends StatefulWidget {
  final TextEditingController controller;

  const ClavierPersonnalise({super.key, required this.controller});

  @override
  State<ClavierPersonnalise> createState() => _ClavierPersonnaliseState();
}

class _ClavierPersonnaliseState extends State<ClavierPersonnalise> {
  String hexValue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double spacing = 8;
          int crossAxisCount = 4;
          List<String> keys = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(spacing),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: 2,
                  ),
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    String key = keys[index];
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.black,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(5),
                        minimumSize: const Size(30, 30),
                        maximumSize: const Size(60, 60),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setState(() {
                          hexValue += key;
                          widget.controller.text = hexValue;
                        });
                      },
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(

                  children: [
                    // Bouton "."
                    Expanded(
                      flex: 1,
                      child: SizedBox(

                        height: 50, // même hauteur pour les deux
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade50,
                            foregroundColor: Colors.black,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            setState(() {
                              hexValue += ".";
                              widget.controller.text = hexValue;
                            });
                          },
                          child: const Text(
                            ".",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: spacing), // espacement entre les boutons

                    // Bouton backspace
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50, // même hauteur
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            if (hexValue.isNotEmpty) {
                              setState(() {
                                hexValue = hexValue.substring(0, hexValue.length - 1);
                                widget.controller.text = hexValue;
                              });
                            }
                          },
                          child: const Icon(Icons.backspace),
                        ),
                      ),
                    ),
                  ],
                ),
              )


            ],
          );
        },
      ),
    );
  }

}

