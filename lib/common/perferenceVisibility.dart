import 'package:flutter/material.dart';
import 'package:project_from_practice_widget/common/perfrance.dart';


class PreferenceVisibility extends StatefulWidget {
  final String preferenceKey;
  final Widget child;

  PreferenceVisibility({required this.preferenceKey, required this.child});

  @override
  _PreferenceVisibilityState createState() => _PreferenceVisibilityState();
}

class _PreferenceVisibilityState extends State<PreferenceVisibility> {
  bool isVisible = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVisibilityPreference();
  }

  Future<void> _loadVisibilityPreference() async {
    try {
      bool? visibility = await PreferenceHelper.instance.getData(widget.preferenceKey);
      setState(() {
        isVisible = visibility ?? true; // Default to true if the preference is null
        _isLoading = false;
      });
    } catch (e) {
      // Handle error here, maybe log it or show a user-friendly message
      print("Error loading preference: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator()); // Show a loader while loading
    } else {
      return Visibility(
        visible: isVisible,
        child: widget.child,
      );
    }
  }
}


//maha
extension on Function() {
  Future<bool?> getData(String preferenceKey) async {}
}