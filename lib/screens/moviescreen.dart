import 'dart:convert';

import 'package:bingr/utils/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MovieScreen extends StatefulWidget {
  final imdbId;
  const MovieScreen({super.key, required this.imdbId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  void initState() {
    super.initState();
    fetchMovie();
  }
  fetchMovie() async {
      await http.get(Uri.parse("https://www.omdbapi.com/?apikey=6162b991&i=${widget.imdbId}")).then((value) {
        var result = jsonDecode(value.body);
        setState(() {
          movieData = result;
          print(movieData);
        });
      });
  }
  Map<String, dynamic> movieData = {};
  @override
  Widget build(BuildContext context) {
    return movieData.isEmpty ? Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        title: Text(movieData['Title']),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movieData['Poster']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Title, Year, and Ratings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${movieData['Title']} (${movieData['Year']})",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("⭐ ${movieData['imdbRating']} ",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.amber)),
                      const SizedBox(width: 10),
                      Text("${movieData['Runtime']} | ${movieData['Genre']}",
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Ratings Row
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieData['Ratings'].length,
                itemBuilder: (context, index) {
                  var rating = movieData['Ratings'][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: modified_text(text: "${rating['Source']}: ${rating['Value']}", fontsize: 14, color: Colors.black,),
                      backgroundColor: Colors.blueGrey.shade50,
                    ),
                  );
                },
              ),
            ),

            // Plot
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Plot: ${movieData['Plot']}",
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // Director, Actors, Awards
            if(movieData['Director'] != "N/A") Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListTile(
                title: const Text("Director"),
                subtitle: Text(movieData['Director']),
              ),
            ),
            if(movieData['Actors'] != "N/A") Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListTile(
                title: const Text("Actors"),
                subtitle: Text(movieData['Actors']),
              ),
            ),
            if(movieData['Awards'] != "N/A") Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListTile(
                title: const Text("Awards"),
                subtitle: Text(movieData['Awards']),
              ),
            ),

            // Box Office Collection
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: movieData['BoxOffice'] != "N/A" || movieData['BoxOffice'] != null || movieData['BoxOffice'] != "null" ? Text(
                "Box Office: ${movieData['BoxOffice']}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ) : SizedBox(height: 5,)
            ),
          ],
        ),
      ),
    );
  }
}