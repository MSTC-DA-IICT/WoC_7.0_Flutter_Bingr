// import 'package:bingr/utils/modified_text.dart';
import 'package:bingr/screens/moviescreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> list;
  const Carousel({super.key, required this.list});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieScreen(imdbId: widget.list[itemIndex]['id'])));
            },
            child: Container(
              width: 290,
              height: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(widget.list[itemIndex]['primaryImage']),
                      fit: BoxFit.cover)),
            ),
          ),
          Text(widget.list[itemIndex]['title'], style: GoogleFonts.lato(textStyle: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
          ),
          maxLines: 1,
          )
        ],
      ),
      options: CarouselOptions(
          height: 350,
          aspectRatio: 2,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2)),
    );
  }
}
