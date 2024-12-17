import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatefulWidget {
  final Color? color;
  final String text;
  final double? fontsize;
  const modified_text({super.key, this.color, required this.text, this.fontsize});

  @override
  State<modified_text> createState() => _modified_textState();
}

class _modified_textState extends State<modified_text> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: GoogleFonts.lato(
      textStyle: TextStyle(
        color: widget.color,
        fontSize: widget.fontsize,
      )
    ),);
  }
}