import 'package:bingr/screens/moviescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowScreen extends StatefulWidget {
  final List<dynamic> Movies;
  final type;
  const ShowScreen({super.key, required this.Movies, required this.type});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            widget.Movies.isEmpty
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
                      itemCount: widget.Movies.length,
                      itemBuilder: (context, index) {
                        var movie = widget.Movies[index];
                        return InkWell(
                          onTap: () {
                            // Action when a movie is tapped
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieScreen(imdbId: movie['id'])));
                            print('Tapped on ${movie['title']}');
                          },
                          child: Stack(children: [
                            Column(
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
                                    image: movie['primaryImage'] != null &&
                                            movie['primaryImage']!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                movie['primaryImage']!),
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
                                  movie['title'] ?? 'No Title',
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
                            Positioned(
                              bottom: 55,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .black54, // Semi-transparent background
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                
                                child: IconButton(onPressed: (){
                                  
                                }, icon: Icon(
                                
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),)
                              ),
                            )
                          ]),
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
