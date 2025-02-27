import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'newscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default theme mode is system
  ThemeMode _themeMode = ThemeMode.system;

  void _setDarkTheme() {
    setState(() {
      _themeMode = ThemeMode.dark; // Switch to Dark Theme
    });
  }

  void _setLightTheme() {
    setState(() {
      _themeMode = ThemeMode.light; // Switch to Light Theme
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, // Use themeMode to switch themes
      home: PageViewScreen(
        setDarkTheme: _setDarkTheme,
        setLightTheme: _setLightTheme,
      ),
    );
  }
}

class PageViewScreen extends StatefulWidget {
  final VoidCallback setLightTheme;
  final VoidCallback setDarkTheme;

  PageViewScreen({required this.setLightTheme, required this.setDarkTheme});

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          FadingTextAnimation(
            setDarkTheme: widget.setDarkTheme,
            setLightTheme: widget.setLightTheme,
          ), // First screen
          newscreen(
            setDarkTheme: widget.setDarkTheme,
            setLightTheme: widget.setLightTheme,
          ), // Second screen
        ],
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final VoidCallback setLightTheme;
  final VoidCallback setDarkTheme;

  FadingTextAnimation({required this.setLightTheme, required this.setDarkTheme});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
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
            onPressed: _showColorPicker, // Open color picker
          ),
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: widget.setLightTheme, // Button for Light Mode
          ),
          IconButton(
            icon: Icon(Icons.nights_stay),
            onPressed: widget.setDarkTheme, // Button for Dark Mode
          ),
       
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
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
