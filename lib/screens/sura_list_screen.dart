import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuraListScreen extends StatefulWidget {
  final Function(String) onSuraSelected;

  SuraListScreen({required this.onSuraSelected});

  @override
  _SuraListScreenState createState() => _SuraListScreenState();
}

class _SuraListScreenState extends State<SuraListScreen> {
  List<String> _suralar = [];

  @override
  void initState() {
    super.initState();
    _loadSuralar();
  }

  void _loadSuralar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _suralar = prefs.getStringList('suralar') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _suralar.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_suralar[index]),
          onTap: () {
            widget.onSuraSelected(_suralar[index]);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
