import 'package:bingr/screens/homescreen.dart';
import 'package:bingr/screens/search_screen.dart';
import 'package:bingr/utils/listview.dart';
import 'package:bingr/utils/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:carousel_slider/carousel_slider.dart';

int selectedIndex = 0;
PageController pc = PageController();
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    void onTapped(int index) {
      setState(() {
        selectedIndex = index;
        pc.jumpToPage(index);
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.grey[500],
          backgroundColor: Colors.transparent,
          title: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Bingr',
                speed: Duration(milliseconds: 500),
                textStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 32,
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
        body: PageView(
          controller: pc,
          children: [
            HomeScreen(),
            SearchScreen(),
            HorizontalList(list: ['dhyey', 'parekh']),
            modified_text(text: "More"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "My List"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey[500],
          onTap: onTapped,
        ),
      ),
    );
  }
}
