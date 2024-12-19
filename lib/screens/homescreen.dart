import 'package:bingr/data/data.dart';
import 'package:bingr/screens/showsScreen.dart';
import 'package:bingr/utils/caraousel.dart';
import 'package:bingr/utils/listview.dart';
import 'package:bingr/utils/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> fruits = ['Apple', 'Mango', 'Banana', 'Guava', 'Papaya'];
  final String apiKey = '184a37a971201824480a3da78fc0c6d6';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODRhMzdhOTcxMjAxODI0NDgwYTNkYTc4ZmMwYzZkNiIsIm5iZiI6MTczNDQyMjkzMi4xODgsInN1YiI6IjY3NjEzMTk0MTU0OGQ4N2E2Y2NiZTBmNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5JZ6-pNtUNlj23oa39DodiawYF0eZj42N9RkN0JpT6M';
  List trendingMovies = [];
  List topratedMovies = [];
  List tv = [];

  bool startRecord = false;


  @override
  void initState() {
    super.initState();
  }

  loadMovies() async {
    print("loading movies");
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();

    print((trendingresult));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: modified_text(text: "Trending Now", fontsize: 20,),
        // ),
        // const SizedBox(height: 12,),
        // // Carousel(list: fruits),
        // SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: modified_text(
            text: "Top Rated Indian Movies",
            fontsize: 20,
          ),
        ),
        Carousel(list: topRatedIndianMovies),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: modified_text(
            text: "Popular Shows",
            fontsize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        HorizontalList(
          list: popularTVShows,
        ),
        Align(
          alignment: Alignment.centerRight, // Align to the right
          child: TextButton(
            onPressed: () {
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
            child: Text("More"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: modified_text(
            text: "Popular Movies globally",
            fontsize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        HorizontalList(list: popularMovies),
        Align(
          alignment: Alignment.centerRight, // Align to the right
          child: TextButton(
            onPressed: () {
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
            child: Text("More"),
          ),
        ),
      ],
    );
  }
}
