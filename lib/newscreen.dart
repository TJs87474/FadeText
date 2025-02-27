import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class newscreen extends StatefulWidget {
  final VoidCallback setLightTheme;
  final VoidCallback setDarkTheme;

  newscreen({required this.setLightTheme, required this.setDarkTheme});

  @override
  _newscreenState createState() => _newscreenState();
}

class _newscreenState extends State<newscreen> {
  bool _isVisible = true;
  Color _textColor = Colors.black; // Default text color

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _textColor; // Temporary color to preview changes
        return AlertDialog(
          title: Text("Pick a Text Color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                tempColor = color; // Store the selected color
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Select"),
              onPressed: () {
                setState(() {
                  _textColor = tempColor; // Apply the selected color
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _showColorPicker, // Open the color picker
          ),
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
          duration: Duration(seconds: 5),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: _textColor),
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
