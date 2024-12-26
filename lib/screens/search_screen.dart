import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bingr/screens/moviescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  List<dynamic> Movies = [];
  TextEditingController _query = TextEditingController();
  @override
  void initState() {
    super.initState();
    make();
    load("cars");
  }

  make() async {
    isAvailable = await speech.initialize();
    print(isAvailable);
    setState(() {});
  }

  void load(String search_key) async {
    await http
        .get(Uri.parse(
            "https://www.omdbapi.com/?apikey=6162b991&s=${search_key}"))
        .then((value) {
      var result = jsonDecode(value.body);
      // print(result);
      setState(() {
        Movies = result['Search'];
        // print(Movies);
      });
    });
  }

  bool startRecord = false;
  final SpeechToText speech = SpeechToText();
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _query,
              onChanged: (value) {
                // Handle real-time search updates
                print('Searching for: $value');
              },
              onSubmitted: (value) {
                query = '';
                setState(() {
                  Movies = [];
                });
                // Handle search when user presses "Enter"
                print('Submitted query: $value');
                load(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for any movie, series or episode...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: AvatarGlow(
                  glowColor: Colors.red,
                  animate: startRecord,
                  child: GestureDetector(
                    onTapDown: (value) {
                      setState(() {
                        startRecord = !startRecord; // Toggle recording state
                      });
                      if (startRecord && isAvailable) {
                        // Start listening
                        speech.listen(
                          onResult: (value) {
                            setState(() {
                              query = value.recognizedWords;
                              print('Recognized query: $query');
                            });
                          },
                          listenFor: Duration(
                              minutes: 1), // Max duration to prevent auto-stop
                          pauseFor:
                              Duration(seconds: 10), // Adjust pause threshold
                          partialResults:
                              true, // Capture partial results for real-time updates
                        );
                      } else {
                        // Stop listening
                        speech.stop();
                        Movies = [];
                        load(query); // Trigger search with the recognized query
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.mic,
                        color: startRecord
                            ? Colors.red
                            : Colors.black, // Visual feedback
                      ),
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[200], // Light background for modern UI
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // Remove default border
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textInputAction: TextInputAction
                  .search, // Adds "Search" button on the keyboard
            ),
            SizedBox(
              height: 15,
            ),
            if (query != '')
              Text(
                query,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            SizedBox(
              height: 15,
            ),
            Movies.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.55, // Adjust ratio for better grid
                      ),
                      itemCount: Movies.length,
                      itemBuilder: (context, index) {
                        var movie = Movies[index];
                        return InkWell(
                          onTap: () {
                            // Action when a movie is tapped
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieScreen(imdbId: movie['imdbID'])));
                            print('Tapped on ${movie['Title']}');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Poster Container
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  image: movie['Poster'] != null &&
                                          movie['Poster']!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(movie['Poster']!),
                                          fit: BoxFit.cover,
                                        )
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/placeholder.png'),
                                          fit: BoxFit.cover,
                                        ),
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Movie Title
                              Text(
                                movie['Title'] ?? 'No Title',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                maxLines: 2, // Avoid overflow
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
