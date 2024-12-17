import 'package:bingr/screens/moviescreen.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  final List<dynamic> list;
  const HorizontalList({super.key, required this.list});

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Specify the height of the ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          final tvShow = widget.list[index];
          return InkWell(
            onTap: () {
              print("Clicked on ${tvShow['id']}");
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieScreen(imdbId: tvShow['id'])));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    padding: EdgeInsets.all(7),
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.pink[50],
                      image: DecorationImage(image: NetworkImage(tvShow['primaryImage']), fit: BoxFit.cover)
                    ),
                  ),
                  Text(tvShow['title']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
