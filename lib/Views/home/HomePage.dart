import 'package:convert_base/Controllers/ConvertBase.dart';
import 'package:convert_base/Views/home/widgets/clavier_personnalise.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<int, String> bases = {
    2: "Binaire",
    8: "Octal",
    10: "Decimal",
    16: "Hexadecimal",
  };

  int? selectedBaseOrigine;
  int? selectedBaseDestination;
  String res = "";

  // bases valides
  List<int> _validBases = [];

  FocusNode hexFocusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  bool showCustomKeyboard = false;
  int dateCurrent = DateTime.now().year;



  void _updateValidBases(String input) {
    // On réinitialise la liste
    _validBases.clear();

    if (input.isEmpty) {
      setState(() {
        selectedBaseOrigine = null;
      });
      return;
    }

    // On vérifie pour chaque base si le nombre est compatible
    if (RegExp(r'^[0-1]+$').hasMatch(input)) _validBases.add(2);
    if (RegExp(r'^[0-7]+$').hasMatch(input)) _validBases.add(8);
    if (RegExp(r'^[0-9]+$').hasMatch(input)) _validBases.add(10);
    if (RegExp(r'^[0-9A-Fa-f]+$').hasMatch(input)) _validBases.add(16);


    setState(() {
      // Si une seule base est possible, on la sélectionne automatiquement
      if (_validBases.length == 1) {
        selectedBaseOrigine = _validBases.first;
      }
      // Si la base précédemment sélectionnée n'est plus valide, on la désélectionne
      else if (selectedBaseOrigine != null && !_validBases.contains(selectedBaseOrigine)) {
        selectedBaseOrigine = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    hexFocusNode.addListener(() {
      if (!hexFocusNode.hasFocus) {
        setState(() => showCustomKeyboard = false);
      }
    });

    controller.addListener(() {
      _updateValidBases(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    hexFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() => showCustomKeyboard = false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ConvertCraft",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          elevation: 4,
          actions: [
            Tooltip(
              message: "Apprenez les méthodes de conversion manuelle",
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/astuces');
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.yellowAccent,
                    size: 26,
                    shadows: [
                      Shadow(
                        color: Colors.yellow,
                        blurRadius: 8,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            focusNode: hexFocusNode,
                            controller: controller,
                            readOnly: true,
                            showCursor:true,
                            onTap: () {
                              setState(() => showCustomKeyboard = true);
                            },
                            decoration: InputDecoration(
                              hintText: "Entrez un nombre",
                              prefixIcon: Icon(Icons.numbers),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // ---------------- BASE ORIGINE -------------------
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: selectedBaseOrigine,
                                hint: Text("Base d'origine", style: Theme.of(context).textTheme.bodyMedium),
                                underline: SizedBox(),
                                items: bases.entries.map((entry) {
                                  // est valide si le champ est vide OU si sa clé est dans la liste des bases valides
                                  final bool isValid = controller.text.isEmpty || _validBases.contains(entry.key);

                                  return DropdownMenuItem<int>(
                                    value: entry.key,
                                    enabled: isValid,
                                    child: Text(
                                      entry.value,
                                      style: TextStyle(
                                        color: isValid ? Theme.of(context).textTheme.bodyMedium!.color : Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),

                                onChanged: (int? value) {
                                  setState(() => selectedBaseOrigine = value);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 20),


                          // ---------------- BASE DESTINATION -------------------
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: selectedBaseDestination,
                                hint: Text("...à convertir en base", style: Theme.of(context).textTheme.bodyMedium),
                                underline: SizedBox(),
                                items: bases.entries.map((entry) {
                                  return DropdownMenuItem<int>(
                                    value: entry.key,
                                    child: Text(entry.value, style: Theme.of(context).textTheme.bodyMedium),
                                  );
                                }).toList(),
                                onChanged: (int? value) {
                                  setState(() => selectedBaseDestination = value);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // ---------------- BUTTON -------------------
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              elevation: 3,
                            ),
                            onPressed: () {
                              final input = controller.text.trim();

                              if (selectedBaseOrigine == null ||
                                  selectedBaseDestination == null ||
                                  input.isEmpty) {
                                setState(() {
                                  res = "Veuillez remplir tous les champs.";
                                });
                                return;
                              }

                              final converter = ConvertBase(
                                number: input,
                                fromBase: selectedBaseOrigine!,
                                toBase: selectedBaseDestination!,
                              );

                              final converterBase = converter.convert();

                              setState(() {
                                res = converterBase.toString();
                                showCustomKeyboard = false;
                                controller.clear();
                                selectedBaseOrigine = null;
                                selectedBaseDestination = null;
                              });
                            },
                            child: Text(
                              "Convertir",
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: 20),

                          // ---------------- RESULT -------------------
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              res.isEmpty ? "Résultat" : res,
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            if (showCustomKeyboard)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClavierPersonnalise(controller: controller),
              )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 8,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: Text(
                "© $dateCurrent Developed by Emmanuel Ble",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}