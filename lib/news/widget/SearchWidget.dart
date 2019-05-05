import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hindText;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTap;

  SearchWidget({Key key, this.hindText, this.onTap, this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 37,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: TextField(
        onTap: onTap,
        onSubmitted: onSubmitted,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 8.0),
          hintText: hindText,
          hintStyle: TextStyle(
              fontSize: 17, color: Color.fromARGB(255, 192, 191, 191)),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
            color: Color.fromARGB(255, 128, 128, 128),
          ),
        ),
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
