import 'package:flutter/material.dart';
import 'add_sura_screen.dart';
import 'sura_list_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/animated_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _count = 0;
  String _selectedSura = "TASBIH";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASBIH"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _confirmReset(context),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddSura(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: SuraListScreen(
          onSuraSelected: (sura) {
            setState(() {
              _selectedSura = sura;
            });
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_count',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white), // Matn rangini oq qilamiz
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white.withOpacity(0.7),
                  child: Text(
                    _selectedSura,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedButton(onPressed: _incrementCount),
              SizedBox(height: 20),
              CustomButton(
                text: 'Zikir qo\'shing',
                onPressed: () => _navigateToAddSura(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hisobni 0 qilmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yo\'q'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _count = 0;
              });
              Navigator.pop(context);
            },
            child: Text('Ha'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddSura(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSuraScreen()),
    );
  }
}
