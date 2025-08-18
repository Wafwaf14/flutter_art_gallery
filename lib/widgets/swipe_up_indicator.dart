// widgets/swipe_up_indicator.dart
import 'package:flutter/material.dart';

class SwipeUpIndicator extends StatelessWidget {
  const SwipeUpIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
        
          
          const SizedBox(height: 8),
          
          _buildArrowIcon(),
        ],
      ),
    );
  }


  Widget _buildArrowIcon() {
    return Icon(
      Icons.keyboard_arrow_up,
      color: Colors.grey.withOpacity(0.7),
      size: 24,
    );
  }
}