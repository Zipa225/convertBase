import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../Models/Astuces.dart';
import 'AstucesDetailScreen.dart';
// import 'astuce_detail_screen.dart';

class AstucesListScreen extends StatefulWidget {
  const AstucesListScreen({super.key});

  @override
  State<AstucesListScreen> createState() => _AstucesListScreenState();
}

class _AstucesListScreenState extends State<AstucesListScreen> {
  late Future<List<Astuce>> _astuces;

  @override
  void initState() {
    super.initState();
    _astuces = _loadAstuces();
  }

  Future<List<Astuce>> _loadAstuces() async {
    final jsonString = await rootBundle.loadString('assets/jsons/astuces.json');
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

    final List<Astuce> astucesList = [];
    jsonMap.forEach((key, value) {
      astucesList.add(
        Astuce(
          id: key,
          titre: value['titre'] ?? '',
          explication: value['explication'] ?? '',
          etapes: List<String>.from(value['etapes'] ?? []),
          exemple: Exemple.fromJson(value['exemple'] ?? {}),
        ),
      );
    });
    return astucesList;
  }

  String _getBaseEmoji(String id) {
    if (id.contains('2')) return '🔢';
    if (id.contains('8')) return '🧮';
    if (id.contains('10')) return '🔟';
    if (id.contains('16')) return '🎨';
    if (id.contains('fraction')) return '➗';

    return '💡';
  }



  Color _getBaseColor(String id) {
    if (id.contains('2')) return const Color(0xFF052659);
    if (id.contains('8')) return const Color(0xFF06B6D4);
    if (id.contains('10')) return const Color(0xFF10B981);
    if (id.contains('16')) return const Color(0xFFF59E0B);
    if (id.contains('fraction')) return const Color(0xFFF59E0B);
    return const Color(0xFF8B5CF6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Astuces de Conversion',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1F2937),
      ),
      body: FutureBuilder<List<Astuce>>(
        future: _astuces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          }

          final astuces = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: astuces.length,
            itemBuilder: (context, index) {
              final astuce = astuces[index];
              final color = _getBaseColor(astuce.id);
              final emoji = _getBaseEmoji(astuce.id);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AstucDetailScreen(astuce: astuce),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                      ),
                      border: Border.all(color: color.withOpacity(0.3), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                emoji,
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  astuce.titre,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  astuce.explication,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: color,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}