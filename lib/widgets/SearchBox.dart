import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final bool supportChangeCallback;
  final String hint;
  final Function(String) callback;

  const SearchBox({super.key, required this.hint, required this.callback, this.supportChangeCallback = true});

  @override
  Widget build(BuildContext context) {
    var searchBar = SearchBar(
      leading: const Icon(Icons.search),
      hintText: hint,
      hintStyle:
      MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
      onChanged: supportChangeCallback ? callback : null,
      onSubmitted: callback,
      shadowColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
      shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )),
      textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.deepPurpleAccent)),
    );

    return Container(
      padding: const EdgeInsets.all(5),
      child: searchBar,
    );
  }
}
