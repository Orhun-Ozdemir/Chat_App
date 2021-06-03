import 'package:flutter/material.dart';

class TextPart extends StatefulWidget {
  final String labelText;
  final double radius;
  final double mhorizontal;
  final double mvertical;
  final double pvertical;
  final double phorizontal;
  final Color textcolor;
  final double wborderside;
  final Color enabledbordercolor;
  final Color focusedcolor;
  final double cwidth;
  final double cheight;
  final TextEditingController controller;
  final String initialValue;
  bool secure;
  String value;
  String erorrText;

  TextPart({
    @required this.labelText,
    this.mhorizontal: 0,
    this.mvertical: 10,
    this.phorizontal: 20,
    this.pvertical: 0,
    this.radius: 5,
    this.textcolor: Colors.yellow,
    this.wborderside: 1.5,
    this.enabledbordercolor: Colors.grey,
    this.focusedcolor: Colors.blue,
    this.cheight: 50,
    this.cwidth: 500,
    this.value,
    this.erorrText,
    this.initialValue,
    @required this.controller,
    this.secure: false,
  }) : assert(labelText != null, "Label text null bir deger olamaz");
  @override
  _TextPartState createState() => _TextPartState();
}

class _TextPartState extends State<TextPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.cheight,
      width: widget.cwidth,
      margin: EdgeInsets.symmetric(
          vertical: widget.mvertical, horizontal: widget.mhorizontal),
      padding: EdgeInsets.symmetric(
          horizontal: widget.phorizontal, vertical: widget.pvertical),
      child: TextFormField(
        showCursor: false,
        obscureText: widget.secure,
        controller: widget.controller,
        decoration: InputDecoration(
          errorText: widget.erorrText,
          filled: false,
          labelText: "${widget.labelText}",
          labelStyle: TextStyle(
              color: widget.textcolor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(width: widget.wborderside, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(width: widget.wborderside, color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(color: widget.focusedcolor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
                color: widget.enabledbordercolor, width: widget.wborderside),
          ),
        ),
        onSaved: (value) {
          setState(() {
            value = value;
          });
        },
      ),
    );
  }
}
