// widgets/artwork_detail_popup.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artwork_full_image_view.dart';
import 'package:untitled3/widgets/artwork_scrollable_view.dart';

class ArtworkDetailPopup extends StatefulWidget {
  final ArtworkModel artwork;
  
  const ArtworkDetailPopup({
    Key? key, 
    required this.artwork,
  }) : super(key: key);

  @override
  _ArtworkDetailPopupState createState() => _ArtworkDetailPopupState();
}

class _ArtworkDetailPopupState extends State<ArtworkDetailPopup>
    with TickerProviderStateMixin {
  late AnimationController _scrollAnimationController;
  late Animation<double> _scrollAnimation;
  bool _isScrollMode = false;

  @override
  void initState() {
    super.initState();
    _scrollAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scrollAnimation = CurvedAnimation(
      parent: _scrollAnimationController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollAnimationController.dispose();
    super.dispose();
  }

  void _switchToScrollMode() {
    if (!_isScrollMode) {
      setState(() {
        _isScrollMode = true;
      });
      _scrollAnimationController.forward();
    }
  }

  Future<void> _closeWithReverseAnimation() async {
    if (_isScrollMode) {
      // عكس الانيميشن للوضع الأول
      await _scrollAnimationController.reverse();
    }
    // ثم إغلاق النافذة
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isScrollMode) {
      // المرحلة الأولى: الصورة كاملة
      return ArtworkFullImageView(
        artwork: widget.artwork,
        onSwitchToScrollMode: _switchToScrollMode,
        onClose: _closeWithReverseAnimation,
      );
    } else {
      // المرحلة الثانية: scroll mode
      return ArtworkScrollableView(
        artwork: widget.artwork,
        animation: _scrollAnimation,
        onClose: _closeWithReverseAnimation,
      );
    }
  }
}