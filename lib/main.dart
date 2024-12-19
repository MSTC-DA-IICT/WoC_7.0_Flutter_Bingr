import 'package:bingr/data/data.dart';
import 'package:bingr/screens/authscreen.dart';
import 'package:bingr/screens/homescreen.dart';
import 'package:bingr/screens/search_screen.dart';
import 'package:bingr/screens/showsScreen.dart';
import 'package:bingr/screens/wishlistscreen.dart';
// import 'package:bingr/utils/listview.dart';
// import 'package:bingr/utils/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:carousel_slider/carousel_slider.dart';

int selectedIndex = 0;
PageController pc = PageController();
String? e;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthScreen());
}

class MainApp extends StatefulWidget {
  final String email;

  MainApp({super.key, required this.email});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState(){
    super.initState();
    e = widget.email;
  }
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text(
        //   "Bingr",
        //   style: TextStyle(
        //     color: Colors.amber[700],
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,
        //   ),
        // ),
        title: AnimatedTextKit(animatedTexts: [
          TypewriterAnimatedText(
            'Bingr',
            textStyle: TextStyle(
            color: Colors.amber[700],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          speed: Duration(milliseconds: 500)
          ),
        ],
        repeatForever: true,
        isRepeatingAnimation: true,

        ),
        centerTitle: true,
      ),
        drawer: Drawer(
          child: Container(
            color: Colors.black87, // Dark background for OTT/movie feel
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Profile Section
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 36,
                    ), // Default profile icon
                  ),
                  accountName: Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    widget.email,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),

                // Navigation Options
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.movie, color: Colors.redAccent),
                        title: Text(
                          "Movies",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Navigate to Movies screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowScreen(
                                Movies: popularMovies,
                                type: "Movies",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.tv, color: Colors.orangeAccent),
                        title: Text(
                          "TV Shows",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Navigate to TV Shows screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowScreen(
                                Movies: popularTVShows,
                                type: "TV Shows",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.star, color: Colors.yellowAccent),
                        title: Text(
                          "Trending Now",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Navigate to Trending screen
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite, color: Colors.pinkAccent),
                        title: Text(
                          "Favorites",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Navigate to Favorites screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WishlistScreen(email: widget.email)
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Divider(color: Colors.grey),

                // Bottom Logout Section
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Add Logout Logic
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: pc,
          children: [
            HomeScreen(),
            SearchScreen(),
            WishlistScreen(email: widget.email)
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "My List"),
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
