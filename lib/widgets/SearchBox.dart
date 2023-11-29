import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final Function(String) callback;

  const SearchBox({super.key, required this.hint, required this.callback});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(5),
      child: SearchBar(
        leading: const Icon(Icons.search),
        hintText: hint,
        hintStyle:
        MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
        onChanged: callback,
        shadowColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
        shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
        textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.deepPurpleAccent)),
      ),
    );
  }
}