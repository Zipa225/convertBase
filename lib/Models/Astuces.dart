class Astuce {
  final String id;
  final String titre;
  final String explication;
  final List<String> etapes;
  final Exemple exemple;

  Astuce({
    required this.id,
    required this.titre,
    required this.explication,
    required this.etapes,
    required this.exemple,
  });

  factory Astuce.fromJson(Map<String, dynamic> json) {
    return Astuce(
      id: json['id'] ?? '',
      titre: json['titre'] ?? '',
      explication: json['explication'] ?? '',
      etapes: List<String>.from(json['etapes'] ?? []),
      exemple: Exemple.fromJson(json['exemple'] ?? {}),
    );
  }
}

class Exemple {
  final String nombre;
  final List<String>? calculs;
  final List<String>? conversion;
  final String? resultat;
  final List<String>? groupes;
  final String? binaire;

  Exemple({
    required this.nombre,
    this.calculs,
    this.conversion,
    this.resultat,
    this.groupes,
    this.binaire,
  });

  factory Exemple.fromJson(Map<String, dynamic> json) {
    return Exemple(
      nombre: json['nombre'] ?? '',
      calculs: json['calculs'] != null ? List<String>.from(json['calculs']) : null,
      conversion: json['conversion'] != null ? List<String>.from(json['conversion']) : null,
      resultat: json['resultat'],
      groupes: json['groupes'] != null ? List<String>.from(json['groupes']) : null,
      binaire: json['binaire'],
    );
  }
}