import 'package:flutter/material.dart';

class ClavierPersonnalise extends StatefulWidget {
  final TextEditingController controller;

  const ClavierPersonnalise({super.key, required this.controller});

  @override
  State<ClavierPersonnalise> createState() => _ClavierPersonnaliseState();
}

class _ClavierPersonnaliseState extends State<ClavierPersonnalise> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  void _onKeyPressed(String key) {
    String currentValue = widget.controller.text;
    String newValue = currentValue + key;
    widget.controller.text = newValue;
    widget.controller.selection = TextSelection.collapsed(offset: newValue.length);
  }

  void _onBackspacePressed() {
    String currentValue = widget.controller.text;
    if (currentValue.isNotEmpty) {
      String newValue = currentValue.substring(0, currentValue.length - 1);
      widget.controller.text = newValue;
      widget.controller.selection = TextSelection.collapsed(offset: newValue.length);
    }
  }

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
          List<String> keys = ["F","E","D","C","B","A","9","8","7","6","5","4","0","1","2","3"];

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
                        _onKeyPressed(key);
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
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
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
                            if (!widget.controller.text.contains('.')) {
                              _onKeyPressed(".");
                            }
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
                    SizedBox(width: spacing),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50,
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
                            _onBackspacePressed();
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