import 'package:flutter/material.dart';
import '../../Models/Astuces.dart';

class AstucDetailScreen extends StatelessWidget {
  final Astuce astuce;

  const AstucDetailScreen({
    super.key,
    required this.astuce,
  });

  Color _getBaseColor(String id) {
    if (id.contains('2')) return const Color(0xFF052659);
    if (id.contains('8')) return const Color(0xFF06B6D4);
    if (id.contains('10')) return const Color(0xFF10B981);
    if (id.contains('16')) return const Color(0xFFF59E0B);
    if (id.contains('fraction')) return const Color(0xFFFFA857);
    return const Color(0xFF8B5CF6);
  }

  @override
  Widget build(BuildContext context) {
    final color = _getBaseColor(astuce.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          astuce.titre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête coloré
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explication',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    astuce.explication,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Étapes
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Étapes',
                    style: TextStyle(
                      // fontFamily:'poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...astuce.etapes.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String etape = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${idx + 1}',
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              etape,
                              style: TextStyle(
                                fontFamily:'poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Exemple
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3), width: 2),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exemple',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildExempleContent(color),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildExempleContent(Color color) {
    final exemple = astuce.exemple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExempleRow('Nombre', exemple.nombre, color),
        const SizedBox(height: 12),
        if (exemple.calculs != null) ...[
          ...exemple.calculs!.map((calc) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildExempleRow('', calc, color),
            );
          }).toList(),
          const SizedBox(height: 12),
        ],
        if (exemple.conversion != null) ...[
          ...exemple.conversion!.map((conv) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildExempleRow('', conv, color),
            );
          }).toList(),
          const SizedBox(height: 12),
        ],
        if (exemple.groupes != null) ...[
          _buildExempleRow('Groupes', exemple.groupes!.join(' | '), color),
          const SizedBox(height: 12),
        ],
        if (exemple.binaire != null) ...[
          _buildExempleRow('Binaire', exemple.binaire!, color),
          const SizedBox(height: 12),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            '✓ ${exemple.resultat}',
            style: TextStyle(
              fontFamily:'poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExempleRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            '$label: ',
            style: TextStyle(

              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'poppins',
            ),
          ),
        ),
      ],
    );
  }
}