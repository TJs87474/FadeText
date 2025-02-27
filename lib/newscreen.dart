import 'package:flutter/material.dart';

class newscreen extends StatefulWidget {
  final VoidCallback setLightTheme;
  final VoidCallback setDarkTheme;

  newscreen({required this.setLightTheme, required this.setDarkTheme});

  @override
  _newscreenState createState() => _newscreenState();
}

class _newscreenState extends State<newscreen> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: widget.setLightTheme, // Switch to Light Mode
          ),
          IconButton(
            icon: Icon(Icons.nights_stay),
            onPressed: widget.setDarkTheme, // Switch to Dark Mode
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 3),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
