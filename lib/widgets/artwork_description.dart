// widgets/artwork_description.dart - Updated to use dynamic content
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class ArtworkDescription extends StatelessWidget {
  final ArtworkModel? artwork;
  
  const ArtworkDescription({
    Key? key,
    this.artwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان القسم
        _buildSectionTitle(),
        
        const SizedBox(height: 16),
        
        // نص الوصف
        _buildDescriptionText(),
        
        const SizedBox(height: 24),
        
        // معلومات إضافية
        if (artwork != null) _buildArtworkInfo(),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return const Text(
      'Artwork Description',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDescriptionText() {
    final description = artwork?.description ?? 
        'This artwork reflects the artist\'s unique vision, blending tradition and modernity to create a unique visual experience. The artist uses colors and shapes in a magical way that attracts viewers, inviting them to contemplate the meanings and engage in action.';
    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.6,
      ),
    );
  }

  Widget _buildArtworkInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تفاصيل العمل',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('الفنان', artwork!.artistName),
          _buildDetailRow('التقنية', artwork!.category),
          _buildDetailRow('السنة', '${DateTime.now().year}'),
          _buildDetailRow('المجموعة', 'مجموعة خاصة'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}