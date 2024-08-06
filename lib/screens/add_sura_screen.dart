import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class AddSuraScreen extends StatefulWidget {
  @override
  _AddSuraScreenState createState() => _AddSuraScreenState();
}

class _AddSuraScreenState extends State<AddSuraScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sura qo\'shing'),
      ),
      body: Stack(
        children: [
          // Orqa fon rasmi
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Rasmning manzili
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: _controller,
                    labelText: 'Sura nomi',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Saqlash',
                      onPressed: _saveSura,
                    ),
                    SizedBox(width: 20),
                    CustomButton(
                      text: 'Bekor qilish',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveSura() async {
    final prefs = await SharedPreferences.getInstance();
    final suralar = prefs.getStringList('suralar') ?? [];
    suralar.add(_controller.text);
    await prefs.setStringList('suralar', suralar);
    Navigator.pop(context);
  }
}
