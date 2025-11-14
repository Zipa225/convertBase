import 'package:convert_base/Controllers/ConvertBase.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declaration des variables
  final Map<int,String> bases = {
    2:"Binaire",
    8:"Octal",
    10:"Decimal",
    16:"Hexadecimal",
  };
  String number ="";
  int? selectedBaseOrigine;
  int? selectedBaseDestination;
  String result = "";
  String res="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text(
          "CONVERTBASE",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.light_mode_outlined,
              color: Colors.white,
            ),

            itemBuilder: (context) {
              return bases.entries.map((base) {
                return PopupMenuItem(
                  value: base.key,
                  child: Text(base.value),
                );
              }).toList();
            },
          ),

          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.lightbulb_outline,
                color: Colors.white,


              ),
          ),
        ],

        centerTitle: true,
        elevation: 4,
      ),

      body: SingleChildScrollView(
        child:ConstrainedBox(
            constraints:BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:EdgeInsets.all(15),
                child: Form(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
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
                          onChanged:(value){
                            setState(() {
                              number=value;
                            });

                          },
                        ),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedBaseOrigine,
                              hint: Text("écrit en base",style: Theme.of(context).textTheme.bodyMedium,),
                              underline: SizedBox(),
                              items:bases.entries.map((entry){
                                return DropdownMenuItem<int>(
                                  value: entry.key,
                                  child: Text(entry.value,style: Theme.of(context).textTheme.bodyMedium),
                                );

                              }).toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  selectedBaseOrigine= value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: selectedBaseDestination,
                              hint: Text("...à convertir en base",style: Theme.of(context).textTheme.bodyMedium),
                              underline: SizedBox(),
                              items: bases.entries.map((entry) {
                                return DropdownMenuItem<int>(
                                  value: entry.key,
                                  child: Text(entry.value,style: Theme.of(context).textTheme.bodyMedium,),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  selectedBaseDestination = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            elevation: 3,
                          ),
                          onPressed: (){
                            if (selectedBaseOrigine == null || selectedBaseDestination == null || number==0) {
                              setState(() {
                                result = "Veuillez remplir tous les champs.";
                              });
                              return;
                            }
                            final converter=ConvertBase(number: number, fromBase: selectedBaseOrigine!, toBase: selectedBaseDestination!);
                            final converterBase=converter.convert();
                            setState(() {
                              res=converterBase.toString();
                            });

                          },
                          child: Text(
                            "Convertir",
                            style: TextStyle(fontSize: 18,color:Colors.white , fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        )
                      ],
                    )
                ),

              ),
            ],
          ),
        ),

      ),

    );
  }
}

